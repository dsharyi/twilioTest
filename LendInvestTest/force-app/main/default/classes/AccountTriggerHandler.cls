public with sharing class AccountTriggerHandler {
    public static final String GOLD_ACCOUNT = 'GOLD';

    public static Set <String> accountsPhonesForSendingSMS = new Set<String>();

    public static void sendSMSForGoldAccounts(List<Account> newAccounts, Map<Id, Account> oldAccountsMap) {
        for (Account newAccount : newAccounts) {
            if (isAccountLoyaltyChangedToGold(oldAccountsMap.get(newAccount.Id), newAccount)) {
                accountsPhonesForSendingSMS.add(newAccount.Phone);
            }
        }
        if (!accountsPhonesForSendingSMS.isEmpty()) {
            TwilioService.sendSMSToGoldAccounts(accountsPhonesForSendingSMS);
        }
    }

    @TestVisible
    private static Boolean isAccountLoyaltyChangedToGold(Account oldAccount, Account newAccount) {
        return oldAccount.Loyalty_programme__c != GOLD_ACCOUNT && newAccount.Loyalty_programme__c == GOLD_ACCOUNT && String.isNotBlank(newAccount.Phone);
    }
}