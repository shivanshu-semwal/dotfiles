OFFSET = 0

def update_bookmark_page_number(line):
    prefix = "BookmarkPageNumber: "
    try:
        num = int(line[len(prefix):])
        updated_num = num - OFFSET
        return f"{prefix}{updated_num}\n"
    except ValueError:
        return line


def main():
    global OFFSET
    input_file = input("Enter the path to the input text file: ")
    OFFSET = int(input("Enter the path to the input text file: "))
    try:
        with open(input_file, 'r') as file:
            lines = file.readlines()

        updated_lines = [update_bookmark_page_number(line) for line in lines]

        output_file = "output.txt"
        with open(output_file, 'w') as file:
            file.writelines(updated_lines)

        print(f"Bookmark page numbers updated and saved to '{output_file}'.")

    except FileNotFoundError:
        print("File not found. Please provide a valid file path.")
    except Exception as e:
        print("An error occurred:", e)


if __name__ == "__main__":
    main()
