URL=https://raw.githubusercontent.com/EBISPOT/efo/master/efo.owl
ONTO=efo.owl
BASE=`basename $ONTO .owl`


## mkdir if it doesnt exist
if [ ! -d "non-obo-mirror" ] ; then
  mkdir non-obo-mirror
fi

## download non-obo ontology
if [ ! -e "non-obo-mirror/$ONTO" ]; then
  cd non-obo-mirror
  curl -OL $URL
  cd ..
fi 


## check for seed file 
if [ ! -e "non-obo-seeds.txt" ]; then
  touch non-obo-seeds.txt
  echo "Please add iris to non-obo-seeds.txt"
  exit 0;
fi

## extract
if [ ! -d "non-obo-imports" ]; then
  mkdir non-obo-imports
fi

robot extract --method BOT --input non-obo-mirror/$ONTO --term-file non-obo-seeds.txt annotate --ontology-iri http://purl.obolibrary.org/obo/planp/non-obo-ontologies/non-obo-imports/${BASE}_imports.owl   --output non-obo-imports/${BASE}_imports.owl

#http://purl.obolibrary.org/obo/planp/non-obo-ontologies/non-obo-imports/efo_imports.owl

#robot convert -vvv --input non-obo-imports/${BASE}_imports.owl --output non-obo-imports/${BASE}_imports.obo
