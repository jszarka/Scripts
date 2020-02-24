#James Szarka Robocopy script
# ver. 0.4 
#Network mounter
$uncServer = "\\192.168.20.35"
$uncFullPath = "$uncServer\d$"
$username = "administrator"
$password = ""
 
net use $uncServer $password /USER:$username


#Data Values
$SourceFolder = "\\192.168.20.35\d$\ClearSCADA\"
$DestinationFolder = "D:\T3400-D-Wed"
$Logfile = "d:\robotest\Robocopy.log"
$threads = "1"
$EmailFrom = "events@szarka.ca"
$EmailTo = "jszarka@szarka.ca"
$EmailBody = "Robocopy has finished. Please Check Attached Logs for success."
$EmailSubject = "<hostname> Robocopy Summary"
$SMTPServer = "mail.szarka.ca"
$SMTPPort = "25"
$Username = "events@szarka.ca"
$Password = ""
# Copy Folder with Robocopy
Robocopy $SourceFolder $DestinationFolder /MIR /LOG:$Logfile /TEE

# Send E-mail message with log file attachment
$Message = New-Object Net.Mail.MailMessage($EmailFrom, $EmailTo, $EmailSubject, $EmailBody)
$Attachment = New-Object Net.Mail.Attachment($Logfile, 'text/plain')
$Message.Attachments.Add($Attachment)
$SMTPClient = New-Object Net.Mail.SmtpClient("mail.szarka.ca", 2525)
$SMTPClient.EnableSsl = $false
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
$SMTPClient.Send($Message)
