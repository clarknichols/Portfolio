echo AWS_PROFILE: $AWS_PROFILE
echo kube-context: $(kubectl config current-context)

read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

export ARGO_NAMESPACE=argo
argo cron list -o name | grep salesforce-extractor | xargs argo cron delete

for f in cronworkflows/*.yaml;
do
  argo cron create $f
done
