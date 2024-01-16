echo "building runner"
dub build -q
echo "finished building"

echo "starting dlang test"
./runner eyJsYW5ndWFnZSI6ImRsYW5nIiwiZW50cnkiOiJhcHAuZCIsIm9wdGlvbnMiOlsiLXEiXSwiZGVwZW5kZW5jaWVzIjp7fSwiZmlsZXMiOlt7Im5hbWUiOiJhcHAuZCIsImNvbnRlbnQiOiJtb2R1bGUgZGlkZTtpbXBvcnQgc3RkLnN0ZGlvO3ZvaWQgbWFpbihzdHJpbmdbXWFyZ3Mpe3dyaXRlbG4oNjkpO30ifV19

echo "starting python test"
./runner eyJsYW5ndWFnZSI6InB5IiwiZW50cnkiOiJhcHAucHkiLCJvcHRpb25zIjpbIi1xIl0sImRlcGVuZGVuY2llcyI6e30sImZpbGVzIjpbeyJuYW1lIjoiYXBwLnB5IiwiY29udGVudCI6InByaW50KDY5KSJ9XX0=

echo "starting java test"
./runner eyJsYW5ndWFnZSI6ImphdmEiLCJlbnRyeSI6Ik1haW4uamF2YSIsIm9wdGlvbnMiOlsiLS1xdWlldCJdLCJkZXBlbmRlbmNpZXMiOnt9LCJmaWxlcyI6W3sibmFtZSI6Ik1haW4uamF2YSIsImNvbnRlbnQiOiJwYWNrYWdlIGRpZGU7cHVibGljIGNsYXNzIE1haW57cHVibGljIHN0YXRpYyB2b2lkIG1haW4oU3RyaW5nLi4uIGFyZ3Mpe1N5c3RlbS5vdXQucHJpbnRsbig2OSk7fX0ifV19