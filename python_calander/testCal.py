# import calendar

# year = 2023

# calendar.setfirstweekday(6)
# obj = calendar.Calendar()
# fullList = []

# for mon in range (12):
#     fullList.append(obj.monthdayscalendar(year, mon+1))

# for ls in fullList:
#     print(len(ls))


# from datetime import date
import holidays

holidays_db = [ [] for _ in range(12) ]

# au_holidays = holidays.country_holidays('AU')
for date, name in sorted(holidays.AU(subdiv='NSW', years=2023).items()):
# for date, name in sorted(holidays.HK( years=2023).items()):
    # print(date, name)
    date = str(date).split('-')
    date=date[1:3]
    print(date)
    holidays_db[int(date[0])-1].append(int(date[1]))

print(holidays_db)
