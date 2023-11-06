codeunit 50046 edmsintegration
{
    procedure GetMethod()
    var
        varAPIIntegrationSetup: Record "Sales & Receivables Setup";
        TempFile: File;
        ToFile: Variant;
        NewStream: InStream;
        HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        TempBlob: Codeunit "Temp Blob";
        jsonobj: JsonObject;
        InStr: InStream;
        Json: Text;
        JSONManagement: Codeunit "JSON Management";
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        JsonText: Text;
        gHttpResponseMsg: HttpResponseMessage;
        gHttpRequestMsg: HttpRequestMessage;
        URL: Text;
        SuccessText: Text;
        Body1: Text;
        Content: HttpContent;
        JObject: JsonObject;
        Jtoken: JsonToken;
        CodeText: JsonToken;
        SIHRec: Record "Sales Invoice Header";
        recRef: RecordRef;
        ObjectJSONManagement: Codeunit "JSON Management";
        SIgnedQR: Text;
        edms: Record EDMSGET;
        output: Text;
        jarray: JsonArray;
        outp: array[1] of text;
        i: Integer;
        jid: JsonToken;
        jcat: JsonToken;
        Jurl: JsonToken;
    begin
        Body1 := '{' +
    '"userId": 1040,' +
    '"roleId": "\"11\",\"1028\"",' +
    '"databaseId":1050,' +
    '"methodId":1,' +
    '"methodParam":"Field19 is null"' +
'}';
        gContent.WriteFrom(Body1);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        gContentHeaders.Add('x-auth-token', 'SkVRRS1DR1NKLUNHUUctWkVLRy1RRUhFLUhBU0o=');
        // gContent.ReadAs(JsonText);
        if gHttpClient.Post('http://10.0.0.8:64000/api/Methods/getMethod', gContent, gHttpResponseMsg) then begin
            // Message(JsonText);
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                MESSAGE(Json);
            END;
            // json := DelChr(Json, '=', '\');
            // json := DelStr(json, 57);
            // Json := DelChr(Json, '=', '//');
            // Message(Json);
        END;

        JSONManagement.InitializeObject(json);
        JSONManagement.GetArrayPropertyValueAsStringByName('outputText', JsonText);
        JsonText := DelChr(JsonText, '=', '\');
        jarray.ReadFrom(JsonText);
        for i := 0 to jarray.Count() - 1 do begin
            jarray.get(i, Jtoken);
            JObject := Jtoken.AsObject();
            Jtoken.AsObject().Get('DocumentId', jid);
            Jtoken.AsObject().Get('Document Category', jcat);
            Jtoken.AsObject().Get('URL', Jurl);
            // Message(jcat.AsValue().AsCode());
            edms.Init();
            edms.Databaseid := '1050';
            edms.DocumentID := jid.AsValue().AsInteger();
            edms.documentTyp := jcat.AsValue().AsCode();
            edms.url := Jurl.AsValue().astext();
            edms.Insert();
        end;
        Clear(Body1);
        Body1 := '{' +
     '"userId": 1040,' +
     '"roleId": "\"11\",\"1028\"",' +
     '"databaseId":1049,' +
     '"methodId":1,' +
     '"methodParam":"Field19 is null"' +
 '}';
        gContent.WriteFrom(Body1);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        gContentHeaders.Add('x-auth-token', 'SkVRRS1DR1NKLUNHUUctWkVLRy1RRUhFLUhBU0o=');
        // gContent.ReadAs(JsonText);
        if gHttpClient.Post('http://10.0.0.8:64000/api/Methods/getMethod', gContent, gHttpResponseMsg) then begin
            // Message(JsonText);
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                // MESSAGE(Json);
            END;
            // json := DelChr(Json, '=', '\');
            // json := DelStr(json, 57);
            // Json := DelChr(Json, '=', '//');
            // Message(Json);
        END;

        JSONManagement.InitializeObject(json);
        JSONManagement.GetArrayPropertyValueAsStringByName('outputText', JsonText);
        JsonText := DelChr(JsonText, '=', '\');
        jarray.ReadFrom(JsonText);
        for i := 0 to jarray.Count() - 1 do begin
            jarray.get(i, Jtoken);
            JObject := Jtoken.AsObject();
            Jtoken.AsObject().Get('DocumentId', jid);
            Jtoken.AsObject().Get('Document Category', jcat);
            Jtoken.AsObject().Get('URL', Jurl);
            // Message(jcat.AsValue().AsCode());
            edms.Init();
            edms.Databaseid := '1049';
            edms.DocumentID := jid.AsValue().AsInteger();
            edms.documentTyp := jcat.AsValue().AsCode();
            edms.url := Jurl.AsValue().astext();
            edms.Insert();
        end;


        Clear(Body1);
        Body1 := '{' +
     '"userId": 1040,' +
     '"roleId": "\"11\",\"1028\"",' +
     '"databaseId":1038,' +
     '"methodId":1,' +
     '"methodParam":"Field19 is null"' +
 '}';
        gContent.WriteFrom(Body1);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        gContentHeaders.Add('x-auth-token', 'SkVRRS1DR1NKLUNHUUctWkVLRy1RRUhFLUhBU0o=');
        // gContent.ReadAs(JsonText);
        if gHttpClient.Post('http://10.0.0.8:64000/api/Methods/getMethod', gContent, gHttpResponseMsg) then begin
            // Message(JsonText);
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                // MESSAGE(Json);
            END;
            // json := DelChr(Json, '=', '\');
            // json := DelStr(json, 57);
            // Json := DelChr(Json, '=', '//');
            // Message(Json);
        END;

        JSONManagement.InitializeObject(json);
        JSONManagement.GetArrayPropertyValueAsStringByName('outputText', JsonText);
        JsonText := DelChr(JsonText, '=', '\');
        jarray.ReadFrom(JsonText);
        for i := 0 to jarray.Count() - 1 do begin
            jarray.get(i, Jtoken);
            JObject := Jtoken.AsObject();
            Jtoken.AsObject().Get('DocumentId', jid);
            Jtoken.AsObject().Get('Document Category', jcat);
            Jtoken.AsObject().Get('URL', Jurl);
            // Message(jcat.AsValue().AsCode());
            edms.Init();
            edms.Databaseid := '1038';
            edms.DocumentID := jid.AsValue().AsInteger();
            edms.documentTyp := jcat.AsValue().AsCode();
            edms.url := Jurl.AsValue().astext();
            edms.Insert();
        end;


        Clear(Body1);
        Body1 := '{' +
     '"userId": 1040,' +
     '"roleId": "\"11\",\"1028\"",' +
     '"databaseId":1040,' +
     '"methodId":1,' +
     '"methodParam":"Field19 is null"' +
 '}';
        gContent.WriteFrom(Body1);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        gContentHeaders.Add('x-auth-token', 'SkVRRS1DR1NKLUNHUUctWkVLRy1RRUhFLUhBU0o=');
        // gContent.ReadAs(JsonText);
        if gHttpClient.Post('http://10.0.0.8:64000/api/Methods/getMethod', gContent, gHttpResponseMsg) then begin
            // Message(JsonText);
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                // MESSAGE(Json);
            END;
            // json := DelChr(Json, '=', '\');
            // json := DelStr(json, 57);
            // Json := DelChr(Json, '=', '//');
            // Message(Json);
        END;

        JSONManagement.InitializeObject(json);
        JSONManagement.GetArrayPropertyValueAsStringByName('outputText', JsonText);
        JsonText := DelChr(JsonText, '=', '\');
        jarray.ReadFrom(JsonText);
        for i := 0 to jarray.Count() - 1 do begin
            jarray.get(i, Jtoken);
            JObject := Jtoken.AsObject();
            Jtoken.AsObject().Get('DocumentId', jid);
            Jtoken.AsObject().Get('Document Category', jcat);
            Jtoken.AsObject().Get('URL', Jurl);
            // Message(jcat.AsValue().AsCode());
            edms.Init();
            edms.Databaseid := '1040';
            edms.DocumentID := jid.AsValue().AsInteger();
            edms.documentTyp := jcat.AsValue().AsCode();
            edms.url := Jurl.AsValue().astext();
            edms.Insert();
        end;

        Clear(Body1);
        Body1 := '{' +
     '"userId": 1040,' +
     '"roleId": "\"11\",\"1028\"",' +
     '"databaseId":1051,' +
     '"methodId":1,' +
     '"methodParam":"Field19 is null"' +
 '}';
        gContent.WriteFrom(Body1);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        gContentHeaders.Add('x-auth-token', 'SkVRRS1DR1NKLUNHUUctWkVLRy1RRUhFLUhBU0o=');
        // gContent.ReadAs(JsonText);
        if gHttpClient.Post('http://10.0.0.8:64000/api/Methods/getMethod', gContent, gHttpResponseMsg) then begin
            // Message(JsonText);
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                // MESSAGE(Json);
            END;
            // json := DelChr(Json, '=', '\');
            // json := DelStr(json, 57);
            // Json := DelChr(Json, '=', '//');
            // Message(Json);
        END;

        JSONManagement.InitializeObject(json);
        JSONManagement.GetArrayPropertyValueAsStringByName('outputText', JsonText);
        JsonText := DelChr(JsonText, '=', '\');
        jarray.ReadFrom(JsonText);
        for i := 0 to jarray.Count() - 1 do begin
            jarray.get(i, Jtoken);
            JObject := Jtoken.AsObject();
            Jtoken.AsObject().Get('DocumentId', jid);
            Jtoken.AsObject().Get('Document Category', jcat);
            Jtoken.AsObject().Get('URL', Jurl);
            // Message(jcat.AsValue().AsCode());
            edms.Init();
            edms.Databaseid := '1051';
            edms.DocumentID := jid.AsValue().AsInteger();
            edms.documentTyp := jcat.AsValue().AsCode();
            edms.url := Jurl.AsValue().astext();
            edms.Insert();
        end;
    end;

    procedure UploadMethod()
    var
        APIIntegrationSetup: Record "Sales & Receivables Setup";
        TempFile: File;
        ToFile: Variant;
        NewStream: InStream;
        HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        TempBlob: Codeunit "Temp Blob";

        InStr: InStream;
        Json: Text;
        JSONManagement: Codeunit "JSON Management";
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        JsonText: Text;
        gHttpResponseMsg: HttpResponseMessage;
        gHttpRequestMsg: HttpRequestMessage;
        URL: Text;
        SuccessText: Text;
        Body1: Text;
        Content: HttpContent;
        JObject: JsonObject;
        Jtoken: JsonToken;
        TextFormat: Text;
        SIHRec: Record "Sales Invoice Header";
        recRef: RecordRef;
        TestFile: file;
        SIgnedQR: Text;
        PPos: codeunit 90;
        FileName: Text[100];
        GLBudgetEntry: Record "G/L Budget Entry";
        outstr: OutStream;
        instrm: InStream;
        tb: TextBuilder;
        ok: text[500];
        filem: Codeunit "File Management";
        EDMSLin1: DotNet EDMSL;
        Resp: Text[2999];

    begin
        FileName := 'D:\Upload\' + 'Upload' + '.pdf';
        REPORT.SaveAsPdf(REPORT::"budgetperformance", FileName, GLBudgetEntry);
        EDMSLin1 := EDMSLin1.EDMSUpload();
        // Resp := EDMSLin1.UploadFile(1028,,FileName);
        // Message(Resp);
    end;
    /* procedure UploadMethod()
     var
         APIIntegrationSetup: Record "Sales & Receivables Setup";
         TempFile: File;
         ToFile: Variant;
         NewStream: InStream;
         HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
         TempBlob: Codeunit "Temp Blob";

         InStr: InStream;
         Json: Text;
         JSONManagement: Codeunit "JSON Management";
         gResponseMsg: Text;
         gRequestMsg: Text;
         gContent: HttpContent;
         gContentHeaders: HttpHeaders;
         gHttpClient: HttpClient;
         JsonText: Text;
         gHttpResponseMsg: HttpResponseMessage;
         gHttpRequestMsg: HttpRequestMessage;
         URL: Text;
         SuccessText: Text;
         Body1: Text;
         Content: HttpContent;
         JObject: JsonObject;
         Jtoken: JsonToken;
         TextFormat: Text;
         SIHRec: Record "Sales Invoice Header";
         recRef: RecordRef;
         TestFile: file;
         SIgnedQR: Text;
         PPos: codeunit 90;
         FileName: Text[500];
         GLBudgetEntry: Record "G/L Budget Entry";
         outstr: OutStream;
         instrm: InStream;
         tb: TextBuilder;
         ok: text[500];
         filem: Codeunit "File Management";
         ContentTypeTxt: TextConst Comment = '{Locked}', ENU = 'multipart/form-data; boundary=%1', ENG = 'multipart/form-data; boundary=%1';
         // TempBLOB : Codeunit TempBlob temporary;
         TempBlobMultiForm: Codeunit "temp blob";
         ResponseInStream: InStream;
         RequestInStream: InStream;
         IntegrationCode: Code[20];
         RequestSuccessful: Boolean;
         ToFileName: Text;
         ResponseBlob: Codeunit "Temp Blob";
         MultiFormManagement: Codeunit multipart;

     begin

         FileName := 'D:\Upload\' + 'Upload' + '.pdf';
         FileName := filem.ServerTempFileName('pdf');
         REPORT.SaveAsPdf(REPORT::"budgetperformance", FileName, GLBudgetEntry);


         TestFile.Open(FileName);
         filem.BLOBImportFromServerFile(TempBlob, FileName);
         TempBlob.CreateInStream(InStr);
         // TestFile.Open(FileName);
         // TestFile.CreateInStream(InStr);
         MultiFormManagement.Initialize();
         MultiFormManagement.AddBodyElement('methodId', '2');
         MultiFormManagement.AddBodyElement('methodParam', '"Id": "-1","filter": "Field13=\' + 'INVT010\' + '","roles":["101","102"],"values":{"Field3": "Annual","Field12": "INVT010","Field4": "2023-03-31","Field1": "Testing API" } }');
         MultiFormManagement.AddFile('methodFile', '', 'Upload.pdf', InStr);
         MultiFormManagement.FinishStream;
         MultiFormManagement.GetBlob(TempBlobMultiForm); 
         MultiFormManagement.FinishStream;
         TempBlobMultiForm.CREATEINSTREAM(InStr);

         gContent.WriteFrom(InStr);
         gContent.GetHeaders(gContentHeaders);
         gContentHeaders.Clear();
         gContentHeaders.Add('Content-Type', 'mulitipart/form-data');

         gContentHeaders.Add('x-auth-token', 'SkVRRS1DR1NKLUNHUUctWkVLRy1RRUhFLUhBU0o=');
         gContent.ReadAs(JsonText);
         Message(JsonText);

         if gHttpClient.Post('http://10.0.0.8:64000/api/Methods/uploadMethod?userId=1040&databaseId=1038', gContent, gHttpResponseMsg) then begin
             gHttpResponseMsg.Content.ReadAs(Json);
             MESSAGE(Json);
             if gHttpResponseMsg.IsSuccessStatusCode then begin
                 MESSAGE(Json);
             END;
         END;
         TestFile.CLOSE;
         //  ERASE(FileName);
     end; */
}