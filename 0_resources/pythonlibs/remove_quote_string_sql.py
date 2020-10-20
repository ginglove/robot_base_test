from convert_list_to_string import convert_list_to_string_without_quote
def remove_quote_string_from_sql(string):
    string_lst= convert_list_to_string_without_quote(string[0])
    print(string_lst)
    return string_lst

def remove_quote_string(string):
    for str in string:
        if "'" in str : string=string.replace("'","")
        if ""  in str : string=string.replace(", ",",")
        if "(" in str : string=string.replace("(","")
        if ")" in str : string=string.replace(")","")
    print(string)
    return string

