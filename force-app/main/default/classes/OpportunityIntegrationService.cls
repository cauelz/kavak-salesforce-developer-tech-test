public class OpportunityIntegrationService {


    @Future(Callout=true)
    public static void execute(String jsonBody) {

        Http http2 = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(jsonBody);
        request.setEndpoint('callout:externalSytstem/post-closed-opportunities');

        HttpResponse response = new HttpResponse();

        try {

            response = http2.send(request);

        } catch (Exception e) {
            System.debug('Json Body: ' + jsonBody + ', Status: ' + response.getStatus() + ', Exception Message: ' + e.getMessage());
        }
    }
}
