trigger AccountTrigger on Account (before update) {

    switch on Trigger.operationType {
        when BEFORE_UPDATE {
            AccountTriggerHandler.sendSMSForGoldAccounts(Trigger.new, Trigger.old);
        }
    }
}