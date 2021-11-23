'''Development script to create_partitions'''

start_year = 1968
end_year = 2022

content = ''.join(
    f'''CREATE TABLE house_price_index_y{current} PARTITION OF house_price_index
    FOR VALUES FROM ('{current}-01-01') TO ('{current+1}-01-01');\n'''
    for current in range(start_year, end_year + 1)
)

# content += '\n'
# content += ''.join(
#     f'ALTER TABLE house_price_index_y{current} ADD CONSTRAINT house_price_index_y{current}_pkey PRIMARY KEY (date, region_name);\n'
#     for current in range(start_year, end_year + 1)
# )

with open('./sql/partitions.sql', 'w') as f:
    f.write(content)