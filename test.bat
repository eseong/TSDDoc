//encrypt.js

var ArgObj=WScript.Arguments;
var drive = ArgObj(0);
var pubring = "E:\\SNP_DATA\\app\\pubring.pkr"
var privring = "E:\\SNP_DATA\\app\\secring.skr";
var passphrase = ArgObj(1);
var recipientid = "0x93303981";
var signingid = "0xB03C7C05";

var inputfile1 = drive + "AS400Out\\MBSC";
var inputfile2 = drive + "AS400Out\\MBLC";

var outputfile1 = drive + "SNPTst\\MBSC";
var outputfile2 = drive + "SNPTst\\MBLC";

var status;
var day = new Date().getDate();
var month = new Date().getMonth()+1;
var year = new Date().getYear();

var datestring = ArgObj(2);

shellobj = WScript.CreateObject("WScript.Shell");
pgpobj = WScript.CreateObject("Nsdpgp3Lib.PGP");

try{
	if(day.toString().length == 1) day = "0" + day;
	if(month.toString().length < 2 ) month = "0" + month;
	if(datestring.length == 0) datestring = day.toString() + month.toString() + year.toString();
	WScript.echo("pubring: " + pubring);
	WScript.echo("privring: " + privring);
	
	// MBSC* Encryption

	WScript.echo("inputfile: " + inputfile1+datestring+".txt");
	WScript.echo("outputfile: " + outputfile1+datestring+".txt.pgp");
	WScript.echo("recipientid: " + recipientid);
    	pgpobj.EncryptFile( pubring, privring, inputfile1+datestring+".txt", outputfile1+datestring+".txt.pgp", 1, 1, recipientid);
	WScript.echo("Successfully MBSC* Encrypted");

	// MSLC* Encryption

	WScript.echo("inputfile: " + inputfile2+datestring+".txt");
	WScript.echo("outputfile: " + outputfile2+datestring+".txt.pgp");
	WScript.echo("recipientid: " + recipientid);
    	pgpobj.EncryptFile( pubring, privring, inputfile2+datestring+".txt", outputfile2+datestring+".txt.pgp", 1, 1, recipientid);
	WScript.echo("Successfully MBLC* Encrypted");
	
}
catch(err)
{
	WScript.echo("Encryption Error - Encrypt.js");
}

