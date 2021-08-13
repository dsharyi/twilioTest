public with sharing class TwilioService {
    
    public static TwilioConfiguration__c twilioConfig = TwilioConfiguration__c.getInstance('TwilioCS');

    public static String credentials = EncodingUtil.base64Encode(Blob.valueOf(twilioConfig.Account_sId__c + ':' + twilioConfig.Auth_Token__c));
    public static String endpoint = twilioConfig.TwilioEndpoint__c + twilioConfig.Account_sId__c + twilioConfig.TwilioTypeOfOperation__c;

    public static List <String> listOfResponseBodiesWithError = new List <String> ();
    public static List <String> listOfBodiesContentSMSWithError = new List <String> ();

    @future (callout = true)
    public static void sendSMSToGoldAccounts(Set <String> mobileNumbersOfAppropriateGoldAccounts){
        for (String mobileNumberOfGoldAccount : mobileNumbersOfAppropriateGoldAccounts) {
            
            String body = 'To=' + mobileNumberOfGoldAccount + '&&' +
            'From=' + twilioConfig.MobileNumberFrom__c + '&&'+
            'Body=' + twilioConfig.SMS_Body__c;

            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            request.setHeader('Authorization', 'Basic '+ credentials);
            request.setEndpoint(endPoint);
            request.setMethod('POST');
            request.setBody(body);

            HttpResponse res = http.send(request);

            if (res.getStatusCode() != 201) {
                listOfResponseBodiesWithError.add(res.getBody());
                listOfBodiesContentSMSWithError.add(body);
            }
        }

        if (!listOfResponseBodiesWithError.isEmpty()) {
            LoggerService.createLoggerFromFailedSMSToGoldAccount(listOfResponseBodiesWithError, listOfBodiesContentSMSWithError);
        }
    }
}