#!/usr/bin/env python3

from PIL import Image, ImageDraw, ImageFont
from datetime import datetime
import calendar

MARGIN = 9
N = 50
WIDTH, HEIGHT = 7 * N + 2 * MARGIN, 7 * N + 2 * MARGIN  # for perfect squares

COLORS = {
    'FOREGROUND': (230, 239, 255),
    'BACKGROUND': (46, 52, 64),
    'COLOR_SCHEME': [
        (244, 108, 117),  # red
        (152, 195, 121),  # green
        (209, 154, 102),  # orange
        (97, 175, 239),  # sky
        (198, 120, 221),  # violet
        (86, 182, 194),  # blue
        (233, 203, 139),  # yellow
    ]
}


def join_image(image1, image2, filename):
    """
    Join two image vertically
    """
    combined_image = Image.new(
        'RGB',
        (max(image1.width, image2.width), image1.height + image2.height)
    )
    combined_image.paste(image1, (0, 0))
    combined_image.paste(image2, (0, image1.height))
    combined_image.save(filename)


def create_cal(WIDTH: int, HEIGHT: int, FONT, MARGIN, COLORS, SHOW_LINES=False):

    IMAGE = Image.new("RGB", (WIDTH, HEIGHT), COLORS['BACKGROUND'])
    STEP_V = int((WIDTH - 2 * MARGIN) / 7)
    STEP_H = int((HEIGHT - 2 * MARGIN) / 7)
    cols, rows = [], []
    H_START, H_END = MARGIN, HEIGHT - MARGIN
    W_START, W_END = MARGIN, WIDTH - MARGIN

    draw = ImageDraw.Draw(IMAGE)

    # Drawing horizontal Lines
    i = 0
    for x in range(MARGIN, WIDTH, STEP_V):
        if SHOW_LINES:
            line = ((x, H_START), (x, H_END))
            draw.line(line, fill=COLORS['FOREGROUND'], width=3)
        cols.append(x)

    # Drawing Horizontal lines
    for x in range(MARGIN, HEIGHT, STEP_H):
        if SHOW_LINES:
            line = ((W_START, x), (W_END, x))
            draw.line(line, fill=COLORS['FOREGROUND'], width=3)
        rows.append(x)

    # Draw dates
    TODAY = datetime.now()
    CUR_DATE = int(TODAY.strftime('%d'))
    CUR_MONTH = int(TODAY.strftime('%m'))
    CUR_YEAR = int(TODAY.strftime('%y'))
    CUR_DAY = TODAY.weekday()

    # Draw weeks
    days = {0: 'Su', 1: 'Mo', 2: 'Tu', 3: 'We', 4: 'Th', 5: 'Fr', 6: 'Sa'}
    for i in range(0, 7):
        text = days[i]
        text_width, text_height = draw.textsize(text, font=FONT)
        position = (
            cols[i] + STEP_V / 2 - (text_width // 2),
            rows[0] + STEP_H / 2 - (text_height // 2)
        )
        draw.text(position, text,
                  fill=COLORS['COLOR_SCHEME'][CUR_DAY], font=FONT)

    # Draw Days
    DAY, END_DATE = calendar.monthrange(CUR_YEAR, CUR_MONTH)
    DAY += 1

    ROW, DATE = 1, 1
    while DATE <= END_DATE:
        text = str(DATE).rjust(2)
        text_width, text_height = draw.textsize(text, font=FONT)
        position = (
            cols[DAY] + STEP_V / 2 - (text_width // 2),
            rows[ROW] + STEP_H / 2 - (text_height // 2)
        )
        if DATE == CUR_DATE:
            draw.ellipse(
                [(cols[DAY], rows[ROW]), (cols[DAY + 1], rows[ROW + 1])], fill=COLORS['COLOR_SCHEME'][CUR_DAY])
            draw.text(position, text, fill=COLORS['BACKGROUND'], font=FONT)
        else:
            draw.text(position, text, fill=COLORS['FOREGROUND'], font=FONT)

        DATE += 1
        DAY = (DAY + 1) % 7

        if DAY == 0:
            ROW += 1

    return IMAGE


def create_title(WIDTH: int, HEIGHT: int, FONT, COLORS):

    TODAY = datetime.now()
    CUR_DATE = int(TODAY.strftime('%d'))
    CUR_DAY = TODAY.weekday()
    CUR_MONTH_NAME = TODAY.strftime('%B')

    IMAGE = Image.new("RGB", (WIDTH, HEIGHT), COLORS['BACKGROUND'])
    draw = ImageDraw.Draw(IMAGE)
    TEXT = str(CUR_DATE) + " " + CUR_MONTH_NAME
    text_width, text_height = draw.textsize(TEXT, font=FONT)
    position = (
        WIDTH / 2 - text_width / 2,
        HEIGHT // 2 - (text_height // 2)
    )
    draw.text(position, TEXT, fill=COLORS['COLOR_SCHEME'][CUR_DAY], font=FONT)
    return IMAGE


FONT1 = ImageFont.truetype(
    "/usr/share/fonts/truetype/Iosevka/Iosevka Medium Nerd Font Complete.ttf",
    20, encoding="unic"
)
IMAGE1 = create_cal(WIDTH, HEIGHT, FONT1, MARGIN, COLORS)

FONT2 = ImageFont.truetype(
    "/usr/share/fonts/opentype/malayalam/Chilanka-Regular.otf",
    50, encoding="unic"
)
IMAGE2 = create_title(WIDTH, 100, FONT2, COLORS)

name='/tmp/' + datetime.today().strftime('%d_%m_%y') + '.png'
join_image(IMAGE2, IMAGE1, name)
