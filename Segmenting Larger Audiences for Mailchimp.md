# Segmenting Larger Audiences
There will be a few times that you need to segment a larger audience for mailchimp mailings. 
This is a step-by-step with a theorhetical audience of 6000 people: You have been requested to create 2 audiences of 1000 people each from this 6000 person segment, and to exclude the rest of the audience members from recieving these emails. The following instructions detail the procces of how to get as close as possible two audiences of 1000.

Make sure your report will give you the following: 
- 18-Digit Contact ID
- 18-Digit Account ID
- Email address

1) Download the report as a CSV, and then open in Excel. Name it something useful like `campaign_master_list.csv`
2) Highlight the entire CSV, and sort by 18-Digit **Contact ID**
3) Copy+Paste 1500 names to another CSV file*
   - ###### **_*1500 is the correct number because about 30 to 50 percent of emails will bounce once we synch with mailchimp_**
   - Copy the next 1500 names to another CSV file
4) Go back into salesforce, and create two campaigns. For this example let's call them `campaign_a` and `campaign_b`
5) get the campaign ID's from both by highlighting the last part of the url.
   - For example: If your URL when viewing your created campaign is `https://newwestsymphony.my.salesforce.com/7exampletext` you will want to highlight `7exampletext`
     - Please Note: the end of a campaign url is always a random string of numbers and letters. `7015c000000r1lM` is an example of one. The campaign with id `7015c000000r1lM` was created for a specific email blast in February of 2022, wherein we created two test audiences.
   - Do this for each campaign, respectively. You should have two campaign ID's set aside, one for campaign_a and another for campaign_b
6) Go into the CSV for each campaign and add two columns, one labeled `Campaign ID` and another labeled `Status`
   - Populate all entries in the Campaign ID column with one of the Campaign ID you copied from the URL earlier. `7exampletext` for example.
   - Repeat this proccess for the other CSV.
   - Populate all entries in the Status column with `Sent`
   - Save both CSV's
7) Go to `https://dataloader.io/` and log in in a Production Environment
   - Click New Task, and then Click Import
   - connection should be `<myusername>@newwestsymphony.com - Production...)`
   - operation should be set to `Insert`
   - Object should be `Campaign Member` (click next)
   - Upload your CSV, and associate 18-Digit Contact ID and Campaign ID with the appropriate objects.
   - Run. **You have now populated your campaigns**
8) Now that you have populated campaigns, go back to salesforce and create an Accounts and Contacts Report
   - Use a cross-filter with Campaign History, and the sub-filter of that should filter by contacts with campaign history where the campaign name is `campaign_a`.
     - In this case, you would be filtering by selecting contacts with history in `campaign_a` for your first report
   - Repeat this report creation for `campaign_b`
