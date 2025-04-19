
secon897d = int(input("Enter a number of seconds:"))
second = secon897d

if second >= 60 and second <=3600: 
    minutes= second/ 60
    print (("The number of minutes in that many seconds."), float(minutes))
elif  second >= 3600 and second <=86400 :
    hours = second/ 3600
    print (("The number of hours in that many seconds."),float(hours))
elif second >= 86400 :
    ays = second/ 86400
    print (("The number of days in that many seconds."), float(ays))





