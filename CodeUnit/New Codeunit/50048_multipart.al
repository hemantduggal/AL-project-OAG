codeunit 50048 multipart
{
    trigger OnRun();
    begin
    end;

    var
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        Boundary: Text;
        NewLine: Text[2];
        BodyOutStream: OutStream;
        Text001: TextConst ENU = 'Content-Disposition: form-data; name="%1"', ENG = 'Content-Disposition: form-data; name="%1"';
        Text002: TextConst ENU = 'Content-Disposition: form-data; name="%1"; filename="%2"', ENG = 'Content-Disposition: form-data; name="%1"; filename="%2"';
        Text003: TextConst ENU = 'Content-Type: %1', ENG = 'Content-Type: %1';

    procedure GenerateBoundary(): Text;
    begin
        Boundary := DELCHR(FORMAT(CURRENTDATETIME), '=', DELCHR(FORMAT(CURRENTDATETIME, 1000), '=', '1234567890'));
        exit(Boundary);
    end;

    procedure Initialize();
    begin
        // TempBlob.Run();
        TempBlob.CREATEOUTSTREAM(BodyOutStream);
        NewLine[1] := 13;
        NewLine[2] := 10;
        Clear(Boundary);
    end;

    procedure AddBodyElement(Element: Text; ElementValue: Text);
    var
        BodyText: BigText;
    begin
        Boundary := DELCHR(FORMAT(CURRENTDATETIME), '=', DELCHR(FORMAT(CURRENTDATETIME, 1000), '=', '1234567890'));

        BodyText.ADDTEXT('--------------------------' + Boundary);
        BodyText.ADDTEXT(NewLine);
        BodyText.ADDTEXT(STRSUBSTNO(Text001, Element));
        BodyText.ADDTEXT(NewLine);
        BodyText.ADDTEXT(NewLine);
        BodyText.ADDTEXT(ElementValue);
        BodyText.ADDTEXT(NewLine);
        BodyText.WRITE(BodyOutStream);
    end;

    procedure AddFile(Element: Text; ElementValue: Text; FileName: Text; FileInStream: InStream);
    var
        BodyText: BigText;
        StreamByte: Byte;
    begin
        Boundary := DELCHR(FORMAT(CURRENTDATETIME), '=', DELCHR(FORMAT(CURRENTDATETIME, 1000), '=', '1234567890'));

        BodyText.ADDTEXT('--------------------------' + Boundary);
        BodyText.ADDTEXT(NewLine);
        BodyText.ADDTEXT(STRSUBSTNO(Text002, Element, FileName));
        BodyText.ADDTEXT(NewLine);
        BodyText.WRITE(BodyOutStream);

        CLEAR(BodyText);
        BodyText.ADDTEXT(NewLine);
        BodyText.ADDTEXT('--------------------------' + Boundary);
        BodyText.Read(FileInStream);
        BodyText.ADDTEXT(NewLine);
        BodyText.ADDTEXT('--------------------------' + Boundary + '--------------------------');
        BodyText.WRITE(BodyOutStream);
        // while not FileInStream.EOS() do begin
        //     FileInStream.READ(StreamByte);
        //     BodyOutStream.WRITE(StreamByte);
        // end;
        // BodyText.ADDTEXT('--------------------------' + Boundary);


        // AddContentType(FileName);

    end;

    procedure GetBlob(var pTempBlob: Codeunit "Temp Blob");
    var
        InStreamTest: InStream;
        OutStreamTest: OutStream;
    begin
        TempBlob.CREATEINSTREAM(InStreamTest, TextEncoding::UTF8);
        pTempBlob.CREATEOUTSTREAM(OutStreamTest, TextEncoding::UTF8);
        COPYSTREAM(OutStreamTest, InStreamTest);
    end;

    local procedure AddContentType(FileName: Text);
    begin
        case FileManagement.GetExtension(FileName) of
            'pdf':
                begin
                    AddContentTypeLine('application/octet-stream');
                end;
            'xml':
                begin
                    AddContentTypeLine('text/xml');
                end;
        end;
    end;

    local procedure AddContentTypeLine(ContentType: Text);
    var
        BodyText: BigText;
    begin
        BodyText.ADDTEXT(STRSUBSTNO(Text003, ContentType));
        BodyText.ADDTEXT(NewLine);
        BodyText.WRITE(BodyOutStream);
    end;

    procedure FinishStream();
    var
        BodyText: BigText;
    begin
        Boundary := DELCHR(FORMAT(CURRENTDATETIME), '=', DELCHR(FORMAT(CURRENTDATETIME, 1000), '=', '1234567890'));

        BodyText.ADDTEXT(NewLine);
        BodyText.ADDTEXT('--------------------------' + Boundary + '--------------------------');
        // BodyText.WRITE(BodyOutStream);
    end;
}