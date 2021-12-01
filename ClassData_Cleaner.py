import pandas as pd
import json

def militarise_time(time):
    try:
        if time == 'None':
            return None
        if time == 'nan':
            return None
        if ('AM' in time) | (('PM' in time) & (time[:2] == '12')):
            return time.replace(' AM', '').replace(' PM', '')
        else:
            time = time.replace(' PM', '')
            timeparts = time.split(':')
            return '{}:{}:{}'.format(int(timeparts[0]) + 12, timeparts[1], timeparts[2])
    except:
        print(time)
        return None
    
df = pd.read_csv('c:/sqlite/spring22_classes.csv')

df['Event End Time'] = df['Event End Time'].apply(lambda x: militarise_time(str(x)))
df['Event Begin Time'] = df['Event Begin Time'].apply(lambda x: militarise_time(str(x)))

for col in df.columns:
    df.rename(columns = {col:col.replace(' ', '')}, inplace=True)


df = df[['ClassPrefix','AcademicTerm', 'ClassCollege', 'Class', 'EventBeginTime', 'EventEndTime', 'EventEarliestEventBeginDate', 'EventLatestEventEndDate', 
        'Section', 'WeeklySchedule', 'Building' ]]

df.drop_duplicates(subset = ['Class', 'Section'], inplace=True)
df['Section'] = df['Section'].apply(lambda x: str(x).replace('Section ', ''))
for col in df.columns:
    
    df[col] = df[col].fillna( '')
    df[col] = df[col].astype(str).replace('NaN', '')
    df[col] = df[col].astype(str).replace('null', '')
    df[col] = df[col].apply(lambda x: x if type(x) == str else '')

count = 0
data = {}
for val in list(df['Class'].unique()):
    data[val.replace(' ', '')] = []
    for sec in list(df[df['Class'] == val]['Section'].unique()):
        tdf = df[(df['Class'] == val) & (df['Section'] == sec)]
        row = {}
        row['Section'] = sec
        for col in tdf.columns:
            row[col] = tdf[col].unique()[0]
        
        count += 1
        data[val.replace(' ', '')].append(row)

out_file = open('Classes_Cleaned_Nested.json','w+')
out_file.write(json.dumps(data))