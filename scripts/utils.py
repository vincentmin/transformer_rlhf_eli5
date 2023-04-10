def get_question(example):
    title = example["title"]
    selftext = example["selftext"]
    if selftext:
        if selftext[-1] not in [".", "?", "!"]:
            seperator = ". "
        else:
            seperator = " "
        question = title + seperator + selftext
    else:
        question = title
    example["question"] = question
    return example
