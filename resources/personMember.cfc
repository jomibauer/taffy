component extends="taffy.core.resource"
taffy_uri="/person/{personID}"
{
    public function get(string personId){
        var person = personService.getPersonById();
        //return person where id == personId
    }
}