# run init.sh !!
from fpdf import FPDF
# pip install fpdf2
import calendar
import holidays
# pip3 install holidays  

month_name_ch = {0:"", 1:"一月", 2:"二月", 3:"三月", 4:"四月", 5:"五月", 6:"六月",
               7:"七月", 8:"八月", 9:"九月", 10:"十月", 11:"十一月", 12:"十二月"}
day_name_jp = ["日","月","火","水","木","金","土"]

year = 2024
obj = calendar.Calendar()
obj.setfirstweekday(6)

MANUAL_HOLIDAY = False

if MANUAL_HOLIDAY:
    holidays_db = [[1,2,26],[],[],[7,8,9,10,11,12,13,14,15,16,25],[29,30,31],[1,2,3,4,12],[],[],[25,26,27,28,29],[2,],[6,7,8,9,10],[25,26]]
else:
    holidays_db = [ [] for _ in range(12) ]
    for date, name in sorted(holidays.AU(subdiv='NSW', years=year).items()):
        date = str(date).split('-')
        date=date[1:3]
        print(date)
        holidays_db[int(date[0])-1].append(int(date[1]))

offset = 3.4

class PDF(FPDF):
    def base (self):
        self.set_fill_color(248,247,232)
        self.rect(0, 0, self.w, self.h, 'F')

    def layout(self, fullmon):
        # this section defines the grid 
        self.set_line_width(0.4)
        self.set_draw_color(209,211,212)
        self.line(430.3, 46.3, 430.3 + 329.9, 46.3)

        # self.set_line_width(0.5)
        self.set_draw_color(209, 211, 212)
        self.line(0, 98.2, self.w, 98.2)
        
        for day in range(7):
            currentX = self.w/7 * (1+day)
            if day < 6:
                self.line(currentX, 72.5, currentX, 98.2)
            # chinese
            self.set_font(family = "Xingkai-Light", size = 22)
            self.set_xy(currentX  - self.w/14 - self.get_string_width(day_name_jp[day])/2, 98.2 - 23.5 )
            self.cell(self.get_string_width(day_name_jp[day]), 22, txt = day_name_jp[day], align='C')
            # English
            self.set_font(family = "SignPainter", size = 13)
            self.set_xy(currentX - self.w/14 + 30, 98.2 - 10)
            self.cell(self.get_string_width(calendar.day_name[(day+7-1)%7]), 13, txt = calendar.day_name[(day+7-1)%7], align='C')

        # draw base 5 rows
        
        for row in range(4):
            self.set_line_width(0.5)
            self.set_draw_color(209,211,212)
            self.line(0, 217.2 + (row)*119, self.w, 217.2 + (row)*119)

        for verL in range(7):
            currentX = self.w/7 * (1+verL)
            if verL < 6:
                top = 98.2
                bottom = 217.2 + 5 * 119 if len(fullmon) == 6 else 217.2 + 4 * 119 
                if (fullmon[0][verL] == 0 and fullmon[0][verL+1] == 0):
                    top = 217.2
                if (fullmon[-1][verL] == 0 and fullmon[-1][verL+1] == 0):
                    bottom = bottom - 119
                self.set_draw_color(209, 211, 212)
                self.line(currentX, top, currentX, bottom)
            
            currentX = self.w/14 + self.w/7 * (verL)
            top = 98.2
            bottom = 217.2 + 5 * 119 if len(fullmon) == 6 else 217.2 + 4 * 119 
            if fullmon[0][verL] == 0: 
                top = 217.2
            if fullmon[-1][verL] == 0:
                bottom = bottom - 119
            self.set_dash_pattern(dash=5, gap=5)
            self.line(currentX, top, currentX, bottom)
            self.set_dash_pattern(0,0)

        if (len(fullmon) == 6):
            self.set_draw_color(209,211,212)
            self.line(0, 217.2 + 4*119, self.w, 217.2 + 4*119)
            self.line(0,  72.5, 0, 217.2 + 5*119)
            self.line(self.w,  72.5, self.w, 217.2 + 5*119)
            self.set_draw_color(25,31,32)
            self.line(0, 217.2 + 5*119, self.w, 217.2 + 5*119)
        else:
            self.set_draw_color(209,211,212)
            self.line(0,  72.5, 0, 217.2 + 4*119)
            self.line(self.w,  72.5, self.w, 217.2 + 4*119)
            self.set_draw_color(25,31,32)
            self.line(0, 217.2 + 4*119, self.w, 217.2 + 4*119)

        self.set_line_width(0.5)
        self.set_draw_color(25,31,32)
        self.line(0, 72.5, self.w, 72.5)

    def month_label(self, mon):
        # chinese
        self.set_font(family = "Xingkai-Light", size = 25)
        self.set_xy(self.w/2 - self.get_string_width(month_name_ch[mon+1])/2, 46.5 - 25)
        self.cell(self.get_string_width(month_name_ch[mon+1]), 25, txt = month_name_ch[mon+1], align='C')
        # English
        self.set_font(family = "SignPainter", size = 20)
        self.set_xy(self.w/2 + 80, 46.5 - 17)
        self.cell(self.get_string_width(calendar.month_name[mon+1]), 20, txt = calendar.month_name[mon+1], align='C')

    def day_highligh_label(self, fullmon, mon):
        '''
        - radius = 21pt
        - color  = 247 173 205 (red) and 173 294 239 (blue)
        - offset = 3.4pt up and left
        '''
        # print(fullmon)
        for i , week in enumerate (fullmon):
            for j, day in enumerate(week):
                if day != 0:
                    current_central = [j * self.w/7 , i * 119 + 98.2]
                    if j == 0 or j == 6 or day in holidays_db[mon]:
                        # sunday and saturday
                        # print('red\t\t',end='')
                        # self.set_line_width(1)
                        self.set_fill_color(247, 173, 205)
                    else:
                        # print('blue\t\t',end='')
                        # self.set_line_width(1)
                        self.set_fill_color(173, 194, 239)
                    self.circle(x=current_central[0] + offset, y=current_central[1] + offset, r=21, style="F")
                    self.set_font(family = "Xingkai-Bold", size = 20)

                    self.set_xy(current_central[0]+ offset + 21/2 - self.get_string_width(str(day)) /2,current_central[1]+ offset + 21 / 2 -10)
                    self.cell(self.get_string_width(str(day)), 20, txt = str(day), align='C')

    def addMon(self, mon):
        fullmon = obj.monthdayscalendar(year, mon+1)
        if (len(fullmon) == 5):
            self.add_page('L', (698.7, 1190.5))
        else:
            self.add_page('L', (817.8, 1190.5))
        print(fullmon)

        self.base()
        self.layout(fullmon)
        self.month_label(mon)
        self.day_highligh_label(fullmon, mon)
        # self.dashed_line(10, 110, 160, 110)

pdf = PDF('L','pt','A3')#pdf object
pdf.add_font(family = 'Xingkai-Light', fname='./fonts/STXingkai-SC-Light.ttf')
pdf.add_font(family = 'Xingkai-Bold', fname='./fonts/STXingkai-SC-Bold.ttf')
pdf.add_font(family = 'SignPainter', fname='./fonts/SignPainter-HouseScript-01.otf')

for mon in range (12):
    pdf.addMon(mon)

pdf.output('calender.pdf')

