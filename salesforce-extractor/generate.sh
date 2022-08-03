for f in cronworkflows/*;
do
    rm $f
done

for f in topics/*.yaml;
do
    d=${f/topics/cronworkflows}
    frep --load $f --delims [[:]] --overwrite CronTemplate.yaml:$d
done
