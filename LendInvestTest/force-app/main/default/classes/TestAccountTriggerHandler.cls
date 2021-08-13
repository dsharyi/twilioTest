@isTest
public with sharing class TestAccountTriggerHandler {
    
    @testSetup 
    static void setup() {
        TwilioConfiguration__c twilioConfig = new TwilioConfiguration__c();
        twilioConfig.Name = UtilConstantsForTest.TWILIO_CS_NAME;
        twilioConfig.Account_sId__c = UtilConstantsForTest.TWILIO_ACCOUNT_SID;
        twilioConfig.Auth_Token__c = UtilConstantsForTest.TWILIO_AUTH_TOKEN;
        twilioConfig.MobileNumberFrom__c = UtilConstantsForTest.TWILIO_MOBILE_NUMBER_FROM;
        twilioConfig.SMS_Body__c = UtilConstantsForTest.TWILIO_SMS_BODY;
        twilioConfig.TwilioEndpoint__c = UtilConstantsForTest.TWILIO_ENDPOINT;
        twilioConfig.TwilioTypeOfOperation__c = UtilConstantsForTest.TWILIO_TYPE_OF_OPERATION;
        insert twilioConfig;

        Test.setMock(HttpCalloutMock.class, new TwilioHttpCalloutMock());

        Account goldAccount = new Account (
            Name = UtilConstantsForTest.GOLD_ACCOUNT_NAME,
            Phone = UtilConstantsForTest.MOBILE_PHONE_ACCOUNT
        );
        
        Account silverAccount = new Account (
            Name = UtilConstantsForTest.SILVER_ACCOUNT_NAME,
            Phone = UtilConstantsForTest.MOBILE_PHONE_ACCOUNT
        );

        List<Account> testAccounts = new List<Account>{goldAccount, silverAccount};
        insert testAccounts;
        
        Opportunity opportunityClosedWonWithGoldAcc = new Opportunity(
            Name = UtilConstantsForTest.GOLD_OPPORTUNITY_NAME,
            AccountId = goldAccount.Id,
            StageName = UtilConstantsForTest.STAGE_CLOSED_WON,
            Amount = UtilConstantsForTest.AMOUNT_GOLD_OPPORTUNITY,
            CloseDate = Date.today()
        );
        

        Opportunity opportunityClosedWonWithSilverAcc = new Opportunity(
            Name = UtilConstantsForTest.SILVER_OPPORTUNITY_NAME,
            AccountId = silverAccount.Id,
            StageName = UtilConstantsForTest.STAGE_CLOSED_WON,
            Amount = UtilConstantsForTest.AMOUNT_SILVER_OPPORTUNITY,
            CloseDate = Date.today()
        );

        List<Opportunity> testOpportunities = new List<Opportunity>{opportunityClosedWonWithGoldAcc, opportunityClosedWonWithSilverAcc};
        insert testOpportunities;
    }

    @isTest 
	static void testIsAccountMustRetrieveSMSNegativeCase() {
        Account accountNotGold = [SELECT Id, Name, Phone, Loyalty_programme__c
                                FROM Account
                                WHERE Name =: UtilConstantsForTest.SILVER_ACCOUNT_NAME
                                LIMIT 1];

        Boolean result = AccountTriggerHandler.isAccountMustRetrieveSMS(accountNotGold);
        System.assertEquals(false, result);
        
    }

    @isTest 
	static void testIsAccountMustRetrieveSMSPositiveCase() {
        Test.setMock(HttpCalloutMock.class, new TwilioHttpCalloutMock());
        Account accountGold = [SELECT Id, Name, Phone, Loyalty_programme__c
                                FROM Account
                                WHERE Name =: UtilConstantsForTest.GOLD_ACCOUNT_NAME
                                LIMIT 1];
        
        Boolean result = AccountTriggerHandler.isAccountMustRetrieveSMS(accountGold);

        System.assertEquals(true, result);  
    }

    @isTest 
    static void testIsAccountLoyaltyChangedToGoldNegativeCase() {
        Test.setMock(HttpCalloutMock.class, new TwilioHttpCalloutMock());
        Account accountGold = [SELECT Id, Name, Phone, Loyalty_programme__c
                                FROM Account
                                WHERE Name =: UtilConstantsForTest.GOLD_ACCOUNT_NAME
                                LIMIT 1];

        Boolean result = AccountTriggerHandler.isAccountLoyaltyChangedToGold(accountGold.Loyalty_programme__c, accountGold.Loyalty_programme__c);
        System.assertEquals(false, result);
        
    }

    @isTest 
    static void testIsAccountLoyaltyChangedToGoldPositiveCase() {
        Test.setMock(HttpCalloutMock.class, new TwilioHttpCalloutMock());
        Account accountNotGold = [SELECT Id, Name, Phone, Loyalty_programme__c
                                FROM Account
                                WHERE Name =: UtilConstantsForTest.SILVER_ACCOUNT_NAME
                                LIMIT 1];

        Account accountGold = [SELECT Id, Name, Phone, Loyalty_programme__c
                                FROM Account
                                WHERE Name =: UtilConstantsForTest.GOLD_ACCOUNT_NAME
                                LIMIT 1];

        Boolean result = AccountTriggerHandler.isAccountLoyaltyChangedToGold(accountNotGold.Loyalty_programme__c, accountGold.Loyalty_programme__c);
        System.assertEquals(true, result);
        
    }

    @isTest 
    static void testSendSMSForGoldAccountsNegativeCase() {
        Test.setMock(HttpCalloutMock.class, new TwilioHttpCalloutMock());
        List<Account> newValuesAccountsGold = [SELECT Id, Name, Phone, Loyalty_programme__c
                                                FROM Account
                                                WHERE Name =: UtilConstantsForTest.GOLD_ACCOUNT_NAME];
                                                
        AccountTriggerHandler.sendSMSForGoldAccounts(newValuesAccountsGold, newValuesAccountsGold);
        System.assertEquals(true, AccountTriggerHandler.accountsPhonesForSendingSMS.isEmpty());
        
    }

    @isTest 
    static void testSendSMSForGoldAccountsPositiveCase() {
        Test.setMock(HttpCalloutMock.class, new TwilioHttpCalloutMock());
        List<Account> newValuesAccounts = [SELECT Id, Name, Phone, Loyalty_programme__c
                                                FROM Account
                                                WHERE Name =: UtilConstantsForTest.GOLD_ACCOUNT_NAME];

        List<Account> oldValuesAccounts = [SELECT Id, Name, Phone, Loyalty_programme__c
                                                FROM Account
                                                WHERE Name =: UtilConstantsForTest.SILVER_ACCOUNT_NAME];                                        
                                                
        AccountTriggerHandler.sendSMSForGoldAccounts(newValuesAccounts, oldValuesAccounts);
        System.assertEquals(false, AccountTriggerHandler.accountsPhonesForSendingSMS.isEmpty());
        
    }
}