import pandas as pd
import json

insecure_file = r'C:\Users\DELL\Documents\Capstone\CSE4\prowler-report\insecure\prowler-insecure.csv'
baseline_file = r'C:\Users\DELL\Documents\Capstone\CSE4\prowler-report\baseline\prowler-baseline.csv'

df_in = pd.read_csv(insecure_file, sep=';', on_bad_lines='skip', low_memory=False)
df_base = pd.read_csv(baseline_file, sep=';', on_bad_lines='skip', low_memory=False)

fail_in = df_in[df_in['STATUS'] == 'FAIL']
fail_base = df_base[df_base['STATUS'] == 'FAIL']

fail_in_keys = set(zip(fail_in['CHECK_ID'], fail_in['RESOURCE_NAME']))
fail_base_keys = set(zip(fail_base['CHECK_ID'], fail_base['RESOURCE_NAME']))

new_fails = fail_in_keys - fail_base_keys
new_fails_df = fail_in[fail_in.apply(lambda x: (x['CHECK_ID'], x['RESOURCE_NAME']) in new_fails, axis=1)]

# Deduplicate to avoid repeating the same finding
new_fails_df = new_fails_df.drop_duplicates(subset=['CHECK_ID', 'RESOURCE_NAME'])
out = new_fails_df[['CHECK_ID', 'RESOURCE_NAME', 'SEVERITY']].to_dict('records')
print(json.dumps(out))
