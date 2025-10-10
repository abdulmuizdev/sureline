import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sureline/core/theme/app_colors.dart';

class FontFamilySelector extends StatefulWidget {
  final Function(String) onFontFamilySelected;
  final VoidCallback onBackPressed;

  const FontFamilySelector({
    super.key,
    required this.onFontFamilySelected,
    required this.onBackPressed,
  });

  @override
  State<FontFamilySelector> createState() => _FontFamilySelectorState();
}

class _FontFamilySelectorState extends State<FontFamilySelector> {
  final List<String> _fontFamilies = [
    'Roboto',
    'Open Sans',
    'Lato',
    'Poppins',
    'Montserrat',
    'Playfair Display',
    'Merriweather',
    'Raleway',
    'PT Serif',
    'Dancing Script',
    'Lora',
    'Nunito',
    'Oswald',
    'Quicksand',
    'Pacifico',
    'Ubuntu',
    'Bebas Neue',
    'Libre Baskerville',
    'Caveat',
    'Josefin Sans',
    'Source Serif Pro',
    'DM Serif Display',
    'Work Sans',
    'Titillium Web',
    'Abril Fatface',
    'Mulish',
    'Zilla Slab',
    'Comfortaa',
    'Arvo',
    'Amatic SC',
    'Fira Sans',
    'Indie Flower',
    'Tinos',
    'Noto Serif',
    'IBM Plex Serif',
    'Anton',
    'Great Vibes',
    'Hind',
    'Rubik',
    'Inconsolata',
    'Cormorant Garamond',
    'Exo 2',
    'Manrope',
    'PT Sans',
    'Signika',
    'Crimson Pro',
    'Questrial',
    'Cardo',
    'Yanone Kaffeesatz',
    'Maven Pro',
    'Bitter',
    'Catamaran',
    'Cabin',
    'Nanum Gothic',
    'Karla',
    'Asap',
    'Inter',
    'Assistant',
    'Domine',
    'Tangerine',
    'Vollkorn',
    'Baloo 2',
    'Noticia Text',
    'Righteous',
    'Noto Sans',
    'Barlow',
    'Archivo',
    'Overpass',
    'El Messiri',
    'Cairo',
    'Chivo',
    'Frank Ruhl Libre',
    'Candal',
    'Oxygen',
    'DM Sans',
    'Tenor Sans',
    'Heebo',
    'Varela Round',
    'Lexend',
    'Sora',
    'Jost',
    'Alfa Slab One',
    'Parisienne',
    'Satisfy',
    'Play',
    'Cinzel',
    'Orbitron',
    'League Spartan',
    'Alegreya',
    'Noto Serif Display',
    'Syne',
    'Bree Serif',
    'Philosopher',
    'Red Hat Display',
    'Glory',
    'Yeseva One',
    'Martel',
    'Trirong',
    'Scope One',
    'Arapey',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: widget.onBackPressed,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.pureWhite,
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primaryColor,
              size: 12,
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          height: 36,
          width: 1,
          color: AppColors.primaryColor.withValues(alpha: 0.1),
        ),
        Expanded(
          child: SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: _fontFamilies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap:
                        () => widget.onFontFamilySelected(_fontFamilies[index]),
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text(
                          _fontFamilies[index],
                          style: GoogleFonts.getFont(
                            _fontFamilies[index],
                            textStyle: TextStyle(),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
