import subprocess
from pathlib import Path

def format_ranges(numbers):
    numbers = sorted(numbers)
    if not numbers:
        return ""

    ranges = []
    start = numbers[0]
    end = numbers[0]

    for i in range(1, len(numbers)):
        if numbers[i] == end + 1:
            end = numbers[i]
        else:
            if start == end:
                ranges.append(f"{start}")
            else:
                ranges.append(f"{start}-{end}")
            start = numbers[i]
            end = numbers[i]

    if start == end:
        ranges.append(f"{start}")
    else:
        ranges.append(f"{start}-{end}")

    return ", ".join(ranges)

def print_table(headers, *columns, indent=0):
    indent = ' ' * indent
    column_widths = [len(header) for header in headers]
    column_widths = [
        max(len(header), max(len(str(value)) for value in values))
        for header, values
        in zip(headers, columns) ]

    separators = [ '-' * width for width in column_widths ]
    row_format = indent + "  ".join([f"{{:<{width}}}" for width in column_widths])

    print(row_format.format(*headers))
    print(row_format.format(*separators))
    for value_set in zip(*columns):
        print(row_format.format(*map(str, value_set)))

def set_def(kwargs, key, value):
    if key not in kwargs:
        kwargs[key] = value

def run_command(command, **kwargs):
    set_def(kwargs, 'shell', True)
    set_def(kwargs, 'check', True)
    set_def(kwargs, 'capture_output', True)
    set_def(kwargs, 'text', True)

    try:
        return subprocess.run(command, **kwargs)
    except subprocess.CalledProcessError as e:
        print(f"Error running command: {e.stderr}")
        raise e

def enumerate_leaves(path_dir):
    path_dir = Path(path_dir)
    test_xml = path_dir / 'test.xml'
    if test_xml.is_file():
        yield path_dir
        return

    for item in path_dir.iterdir():
        if item.is_dir():
            yield from enumerate_leaves(item)

def check_env(*args):
    pass

def print_separator():
    print()
    print('<>' * 42)
    print()
