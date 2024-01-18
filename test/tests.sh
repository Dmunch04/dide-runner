GREEN="\033[0;32m"
YELLOW="\033[0;33m"
LIGHT_GRAY="\033[0;37m"
CLEAR="\033[0m"

echo "building runner"
dub build -q
echo -e "${GREEN}finished building${CLEAR}"
echo

all_start=$(date +%s%N)

echo "starting dlang test"
start=$(date +%s%N)
printf "${GREEN}"
./runner eyJsYW5ndWFnZSI6ImRsYW5nIiwiZW50cnkiOiJhcHAuZCIsIm9wdGlvbnMiOlsiLXEiXSwiZGVwZW5kZW5jaWVzIjp7fSwiZmlsZXMiOlt7Im5hbWUiOiJhcHAuZCIsImNvbnRlbnQiOiJtb2R1bGUgZGlkZTtpbXBvcnQgc3RkLnN0ZGlvO3ZvaWQgbWFpbihzdHJpbmdbXWFyZ3Mpe3dyaXRlbG4oNjkpO30ifV19
echo -e "${LIGHT_GRAY}finished in ${YELLOW}$(($(($(date +%s%N)-$start))/1000000))ms${CLEAR}"
echo

echo "starting python test"
start=$(date +%s%N)
printf "${GREEN}"
./runner eyJsYW5ndWFnZSI6InB5IiwiZW50cnkiOiJhcHAucHkiLCJvcHRpb25zIjpbIi1xIl0sImRlcGVuZGVuY2llcyI6e30sImZpbGVzIjpbeyJuYW1lIjoiYXBwLnB5IiwiY29udGVudCI6InByaW50KDY5KSJ9XX0=
echo -e "${LIGHT_GRAY}finished in ${YELLOW}$(($(($(date +%s%N)-$start))/1000000))ms${CLEAR}"
echo

echo "starting java test"
start=$(date +%s%N)
printf "${GREEN}"
./runner eyJsYW5ndWFnZSI6ImphdmEiLCJlbnRyeSI6Ik1haW4uamF2YSIsIm9wdGlvbnMiOlsiLS1xdWlldCJdLCJkZXBlbmRlbmNpZXMiOnt9LCJmaWxlcyI6W3sibmFtZSI6Ik1haW4uamF2YSIsImNvbnRlbnQiOiJwYWNrYWdlIGRpZGU7cHVibGljIGNsYXNzIE1haW57cHVibGljIHN0YXRpYyB2b2lkIG1haW4oU3RyaW5nLi4uIGFyZ3Mpe1N5c3RlbS5vdXQucHJpbnRsbig2OSk7fX0ifV19
echo -e "${LIGHT_GRAY}finished in ${YELLOW}$(($(($(date +%s%N)-$start))/1000000))ms${CLEAR}"
echo

echo "starting kotlin test"
start=$(date +%s%N)
printf "${GREEN}"
./runner eyJsYW5ndWFnZSI6Imt0IiwiZW50cnkiOiJNYWluLmt0Iiwib3B0aW9ucyI6WyItcSJdLCJkZXBlbmRlbmNpZXMiOnt9LCJmaWxlcyI6W3sibmFtZSI6Ik1haW4ua3QiLCJjb250ZW50IjoicGFja2FnZSBkaWRlXG5mdW4gbWFpbigpe3ByaW50bG4oNjkpfSJ9XX0=
echo -e "${LIGHT_GRAY}finished in ${YELLOW}$(($(($(date +%s%N)-$start))/1000000))ms${CLEAR}"
echo

echo "starting c# test"
start=$(date +%s%N)
printf "${GREEN}"
./runner eyJsYW5ndWFnZSI6ImNzIiwiZW50cnkiOiJQcm9ncmFtLmNzIiwib3B0aW9ucyI6WyItcSJdLCJkZXBlbmRlbmNpZXMiOnt9LCJmaWxlcyI6W3sibmFtZSI6IlByb2dyYW0uY3MiLCJjb250ZW50IjoibmFtZXNwYWNlIEhlbGxvV29ybGR7Y2xhc3MgSGVsbG97c3RhdGljIHZvaWQgTWFpbihzdHJpbmdbXSBhcmdzKXtTeXN0ZW0uQ29uc29sZS5Xcml0ZUxpbmUoNjkpO319fSJ9XX0=
echo -e "${LIGHT_GRAY}finished in ${YELLOW}$(($(($(date +%s%N)-$start))/1000000))ms${CLEAR}"
echo

echo "starting javascript test"
start=$(date +%s%N)
printf "${GREEN}"
./runner eyJsYW5ndWFnZSI6ImpzIiwiZW50cnkiOiJhcHAuanMiLCJvcHRpb25zIjpbIi1xIl0sImRlcGVuZGVuY2llcyI6e30sImZpbGVzIjpbeyJuYW1lIjoiYXBwLmpzIiwiY29udGVudCI6ImNvbnNvbGUubG9nKDY5KTsifV19
echo -e "${LIGHT_GRAY}finished in ${YELLOW}$(($(($(date +%s%N)-$start))/1000000))ms${CLEAR}"
echo

echo "starting typescript test"
start=$(date +%s%N)
printf "${GREEN}"
./runner eyJsYW5ndWFnZSI6InRzIiwiZW50cnkiOiJhcHAudHMiLCJvcHRpb25zIjpbIi1xIl0sImRlcGVuZGVuY2llcyI6e30sImZpbGVzIjpbeyJuYW1lIjoiYXBwLnRzIiwiY29udGVudCI6ImxldCBtZXNzYWdlOm51bWJlcj02OTtjb25zb2xlLmxvZyhtZXNzYWdlKTsifV19
echo -e "${LIGHT_GRAY}finished in ${YELLOW}$(($(($(date +%s%N)-$start))/1000000))ms${CLEAR}"
echo

echo "starting golang test"
start=$(date +%s%N)
printf "${GREEN}"
./runner eyJsYW5ndWFnZSI6ImdvIiwiZW50cnkiOiJhcHAuZ28iLCJvcHRpb25zIjpbIi1xIl0sImRlcGVuZGVuY2llcyI6e30sImZpbGVzIjpbeyJuYW1lIjoiYXBwLmdvIiwiY29udGVudCI6InBhY2thZ2UgbWFpblxuaW1wb3J0IFwiZm10XCJcbmZ1bmMgbWFpbigpe2ZtdC5QcmludGxuKDY5KX0ifV19
echo -e "${LIGHT_GRAY}finished in ${YELLOW}$(($(($(date +%s%N)-$start))/1000000))ms${CLEAR}"
echo

# rust, zig?, scala?, ?

echo -e "${CLEAR}finished all tests in ${GREEN}$(($(($(date +%s%N)-$all_start))/1000000))ms"