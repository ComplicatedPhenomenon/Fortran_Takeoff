!< FACE test.
program face_test
!< FACE test.
use face

implicit none

#ifdef UCS4_SUPPORTED
character(kind=UCS4, len=:), allocatable :: string_1 !< A string.
character(kind=UCS4, len=:), allocatable :: string_2 !< A string.
character(kind=UCS4, len=:), allocatable :: string_3 !< A string.

string_1 = colorize('Hello', color_fg='blue')
string_2 = colorize(UCS4_' ÜÇŞ4', color_fg='red')
string_3 = colorize(' World', color_fg='blue')
print '(A)', string_1//string_2//string_3
#endif

call colors_samples
call styles_samples

print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='black'          )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='red'            )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='green'          )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='yellow'         )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='blue'           )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='magenta'        )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='cyan'           )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='white'          )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='default'        )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='black_intense'  )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='red_intense'    )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='green_intense'  )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='yellow_intense' )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='blue_intense'   )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='magenta_intense')
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='cyan_intense'   )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='white_intense'  )

print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='black'          )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='red'            )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='green'          )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='yellow'         )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='blue'           )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='magenta'        )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='cyan'           )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='white'          )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='default'        )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='black_intense'  )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='red_intense'    )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='green_intense'  )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='yellow_intense' )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='blue_intense'   )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='magenta_intense')
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='cyan_intense'   )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_bg='white_intense'  )


print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='blue', style='bold_on'         )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='blue', style='italics_on'      )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='blue', style='underline_on'    )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='blue', style='inverse_on'      )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='blue', style='strikethrough_on')
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='blue', style='framed_on'       )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='blue', style='encircled_on'    )
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='blue', style='overlined_on'    )
endprogram face_test
