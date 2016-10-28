# Wardrobe Management App

To run:

```
perl Makefile.PL
make
perl bin/app.pl
```

Visit http://localhost:3000/

From here you can
 * Upload clothes catalogue (do this first!)
 * Browse all clothers
 * Saarch by name (exact match only)

## Limitations:
 * No working 'Outfit' yet

## Given more time....:
 * Stop using KiokuDB DBI 'search' - use GIN search
 * Use GUIDs rather than line names
 * Add 'Outfit' story, backed to the database
 * Display outfits vs the listed clothing lines.

Written against Perl v5.22 - should be ok with most older Perls. Moose likes 5.10+ IIRC.

