def process_file(filename):
    with open(filename, 'r') as file:
        lines = file.readlines()

    with open(filename, 'w') as file:
        for line in lines:
            # Split the line at the first space and keep only the first part
            new_line = line.split('\t', )[0]
            file.write(new_line + "\n")

process_file("ticker.txt")