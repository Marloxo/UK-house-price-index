from configparser import RawConfigParser

CONFIG_FILE='/secret/database.ini'

# NOTE: THIS NOT MEANT TO BE USED IN PRODUCTION, IT'S ONLY TO SIMPLY TEST THE CODE
# alternative would be using secret manager.

def getConfig(section):
    parser = RawConfigParser()
    parser.read(CONFIG_FILE)
    if parser.has_section(section):
        db = { param[0] : param[1] for param in parser.items(section)}
    else:
        raise Exception(f"Section {section} not found in the {CONFIG_FILE} file")

    return db
