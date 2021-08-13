public with sharing class TwilioService {
    
    private static TwilioConfiguration__c twilioConfig = TwilioConfiguration__c.getInstance('TwilioCS');

    private static final String TWILIO_TYPE_SERVICE = 'Twilio';

    @future (callout = true)
    public static void sendSMSToGoldAccounts(Set <String> mobileNumbersOfAppropriateGoldAccounts){
        for (String mobileNumberOfGoldAccount : mobileNumbersOfAppropriateGoldAccounts) {
            
            String body = 'To=' + mobileNumberOfGoldAccount + '&&' +
            'From=' + twilioConfig.MobileNumberFrom__c + '&&'+
            'Body=' + twilioConfig.SMS_Body__c;

            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            request.setHeader('Authorization', 'Basic '+ EncodingUtil.base64Encode(Blob.valueOf(twilioConfig.Account_sId__c + ':' + twilioConfig.Auth_Token__c));
            request.setEndpoint(twilioConfig.TwilioEndpoint__c + twilioConfig.Account_sId__c + twilioConfig.TwilioTypeOfOperation__c);
            request.setMethod('POST');
            request.setBody(body);

            HttpResponse res = http.send(request);

            if (res.getStatusCode() != 201) {
                LoggerServiceDTO dto = new LoggerServiceDTO ();
                dto.errorBody = res.getBody().substringBetween('message": "', '"');
                dto.origin = TWILIO_TYPE_SERVICE;

                LoggerService.createLog(dto);
            }
        }
    }
}
