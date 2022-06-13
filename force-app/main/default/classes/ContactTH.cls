public class ContactTH {

    public static ContactService service;

    static {
        service = new ContactService();
    }

    public static void afterUpdateHandler(List<Contact> newContacts, Map<Id, Contact> oldContacts) {

        service.updateOpportunitiesFullName(contactsMappedByAccountIdThatChangedName(newContacts, oldContacts));

    }

    public static Map<Id, Contact> contactsMappedByAccountIdThatChangedName(List<Contact> newContacts, Map<Id, Contact> oldContacts) {

        Map<Id, Contact> contactMappedByAccountId = new Map<Id, Contact>();

        if(newContacts == null || newContacts.isEmpty()) return contactMappedByAccountId;

        for(Contact contact : newContacts) {

            if(contact.AccountId != null && (contact.Name != oldContacts.get(contact.Id).Name || contact.LastName != oldContacts.get(contact.Id).LastName)) {
                
                contactMappedByAccountId.put(contact.AccountId, contact);

            }

        }

        return contactMappedByAccountId;
    }

}
