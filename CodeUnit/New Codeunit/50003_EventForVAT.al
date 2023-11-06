codeunit 50003 EventSubscriber
{
    //vendor
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterValidateEvent', 'VAT Registration No.', false, false)]
    local procedure OnAfterValidateVatRegitration(var Rec: Record Vendor; var xrec: record vendor);
    var
        currentvalue: Integer;
        p_gText: Text[30];
        p_gText1: Text[30];
        p_gText2: Text[30];
        p_gTextG: Text[30];
        p_gTextG1: Text[30];
        p_gTextG2: Text[30];
        p_gTextG3: Text[30];
        p_gTextG4: Text[30];
        p_gTextG5: Text[30];
        p_gTextG6: Text[30];
    begin
        Clear(currentvalue);
        currentvalue := StrLen(rec."VAT Registration No.");
        if currentvalue <> 10 then
            Error('Tin No. must have 10digit');

        p_gText := '';
        p_gText := COPYSTR(Rec."VAT Registration No.", 1, 1);
        p_gTextG := '';
        p_gTextG := COPYSTR(Rec."VAT Registration No.", 2, 1);
        p_gTextG1 := '';
        p_gTextG1 := COPYSTR(Rec."VAT Registration No.", 3, 1);
        p_gTextG2 := '';
        p_gTextG2 := COPYSTR(Rec."VAT Registration No.", 4, 1);
        p_gTextG3 := '';
        p_gTextG3 := COPYSTR(Rec."VAT Registration No.", 5, 1);
        p_gText1 := '';
        p_gText1 := COPYSTR(Rec."VAT Registration No.", 6, 1);
        p_gTextG4 := '';
        p_gTextG4 := COPYSTR(Rec."VAT Registration No.", 7, 1);
        p_gTextG5 := '';
        p_gTextG5 := COPYSTR(Rec."VAT Registration No.", 8, 1);
        p_gTextG6 := '';
        p_gTextG6 := COPYSTR(Rec."VAT Registration No.", 9, 1);
        p_gText2 := '';
        p_gText2 := COPYSTR(Rec."VAT Registration No.", 10);
        //
        IF NOT (p_gText IN ['0' .. '9']) THEN
            ERROR('First charecter need to be Numeric');

        IF NOT (p_gTextG IN ['0' .. '9']) THEN
            ERROR('Secound charecter need to be Numeric');

        IF NOT (p_gTextG1 IN ['0' .. '9']) THEN
            ERROR('Third charecter need to be Numeric');

        IF NOT (p_gTextG2 IN ['0' .. '9']) THEN
            ERROR('Fourth charecter need to be Numeric');

        IF NOT (p_gTextG3 IN ['0' .. '9']) THEN
            ERROR('Fifth charecter need to be Numeric');

        IF NOT (FORMAT(p_gText1) IN ['0' .. '9']) THEN
            ERROR('Sixth charecter need to be Numeric');

        IF NOT (FORMAT(p_gTextG4) IN ['0' .. '9']) THEN
            ERROR('Seventh charecter need to be Numeric');

        IF NOT (FORMAT(p_gTextG5) IN ['0' .. '9']) THEN
            ERROR('Eight charecter need to be Numeric');

        IF NOT (FORMAT(p_gTextG6) IN ['0' .. '9']) THEN
            ERROR('Ninth charecter need to be Numeric');

        IF NOT (p_gText2 IN ['0' .. '9']) THEN
            ERROR('last charecter need to be Numeric');
        //
    end;

    /////customer
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'VAT Registration No.', false, false)]
    local procedure OnAfterValidateVatRegitrationCustomer(var Rec: Record Customer; var xrec: record Customer);
    var
        currentvalue: Integer;
        p_gText: Text[30];
        p_gText1: Text[30];
        p_gText2: Text[30];
        p_gTextG: Text[30];
        p_gTextG1: Text[30];
        p_gTextG2: Text[30];
        p_gTextG3: Text[30];
        p_gTextG4: Text[30];
        p_gTextG5: Text[30];
        p_gTextG6: Text[30];
    begin
        Clear(currentvalue);
        currentvalue := StrLen(rec."VAT Registration No.");
        if currentvalue <> 10 then
            Error('TIN No. must have 10digit');

        p_gText := '';
        p_gText := COPYSTR(Rec."VAT Registration No.", 1, 1);
        p_gTextG := '';
        p_gTextG := COPYSTR(Rec."VAT Registration No.", 2, 1);
        p_gTextG1 := '';
        p_gTextG1 := COPYSTR(Rec."VAT Registration No.", 3, 1);
        p_gTextG2 := '';
        p_gTextG2 := COPYSTR(Rec."VAT Registration No.", 4, 1);
        p_gTextG3 := '';
        p_gTextG3 := COPYSTR(Rec."VAT Registration No.", 5, 1);
        p_gText1 := '';
        p_gText1 := COPYSTR(Rec."VAT Registration No.", 6, 1);
        p_gTextG4 := '';
        p_gTextG4 := COPYSTR(Rec."VAT Registration No.", 7, 1);
        p_gTextG5 := '';
        p_gTextG5 := COPYSTR(Rec."VAT Registration No.", 8, 1);
        p_gTextG6 := '';
        p_gTextG6 := COPYSTR(Rec."VAT Registration No.", 9, 1);
        p_gText2 := '';
        p_gText2 := COPYSTR(Rec."VAT Registration No.", 10);
        //
        IF NOT (p_gText IN ['0' .. '9']) THEN
            ERROR('First charecter need to be Numeric');

        IF NOT (p_gTextG IN ['0' .. '9']) THEN
            ERROR('Secound charecter need to be Numeric');

        IF NOT (p_gTextG1 IN ['0' .. '9']) THEN
            ERROR('Third charecter need to be Numeric');

        IF NOT (p_gTextG2 IN ['0' .. '9']) THEN
            ERROR('Fourth charecter need to be Numeric');

        IF NOT (p_gTextG3 IN ['0' .. '9']) THEN
            ERROR('Fifth charecter need to be Numeric');

        IF NOT (FORMAT(p_gText1) IN ['0' .. '9']) THEN
            ERROR('Sixth charecter need to be Numeric');

        IF NOT (FORMAT(p_gTextG4) IN ['0' .. '9']) THEN
            ERROR('Seventh charecter need to be Numeric');

        IF NOT (FORMAT(p_gTextG5) IN ['0' .. '9']) THEN
            ERROR('Eight charecter need to be Numeric');

        IF NOT (FORMAT(p_gTextG6) IN ['0' .. '9']) THEN
            ERROR('Ninth charecter need to be Numeric');

        IF NOT (p_gText2 IN ['0' .. '9']) THEN
            ERROR('last charecter need to be Numeric');
        //
    end;

    /////Company information
    [EventSubscriber(ObjectType::Table, Database::"Company Information", 'OnAfterValidateEvent', 'VAT Registration No.', false, false)]
    local procedure OnAfterValidateVatRegitrationCmpInfo(var Rec: Record "Company Information"; var xrec: record "Company Information");
    var
        currentvalue: Integer;
        p_gText: Text[30];
        p_gText1: Text[30];
        p_gText2: Text[30];
        p_gTextG: Text[30];
        p_gTextG1: Text[30];
        p_gTextG2: Text[30];
        p_gTextG3: Text[30];
        p_gTextG4: Text[30];
        p_gTextG5: Text[30];
        p_gTextG6: Text[30];
    begin
        Clear(currentvalue);
        currentvalue := StrLen(rec."VAT Registration No.");
        if currentvalue <> 10 then
            Error('TIN No. must have 10digit');

        p_gText := '';
        p_gText := COPYSTR(Rec."VAT Registration No.", 1, 1);
        p_gTextG := '';
        p_gTextG := COPYSTR(Rec."VAT Registration No.", 2, 1);
        p_gTextG1 := '';
        p_gTextG1 := COPYSTR(Rec."VAT Registration No.", 3, 1);
        p_gTextG2 := '';
        p_gTextG2 := COPYSTR(Rec."VAT Registration No.", 4, 1);
        p_gTextG3 := '';
        p_gTextG3 := COPYSTR(Rec."VAT Registration No.", 5, 1);
        p_gText1 := '';
        p_gText1 := COPYSTR(Rec."VAT Registration No.", 6, 1);
        p_gTextG4 := '';
        p_gTextG4 := COPYSTR(Rec."VAT Registration No.", 7, 1);
        p_gTextG5 := '';
        p_gTextG5 := COPYSTR(Rec."VAT Registration No.", 8, 1);
        p_gTextG6 := '';
        p_gTextG6 := COPYSTR(Rec."VAT Registration No.", 9, 1);
        p_gText2 := '';
        p_gText2 := COPYSTR(Rec."VAT Registration No.", 10);
        //
        IF NOT (p_gText IN ['0' .. '9']) THEN
            ERROR('First charecter need to be Numeric');

        IF NOT (p_gTextG IN ['0' .. '9']) THEN
            ERROR('Secound charecter need to be Numeric');

        IF NOT (p_gTextG1 IN ['0' .. '9']) THEN
            ERROR('Third charecter need to be Numeric');

        IF NOT (p_gTextG2 IN ['0' .. '9']) THEN
            ERROR('Fourth charecter need to be Numeric');

        IF NOT (p_gTextG3 IN ['0' .. '9']) THEN
            ERROR('Fifth charecter need to be Numeric');

        IF NOT (FORMAT(p_gText1) IN ['0' .. '9']) THEN
            ERROR('Sixth charecter need to be Numeric');

        IF NOT (FORMAT(p_gTextG4) IN ['0' .. '9']) THEN
            ERROR('Seventh charecter need to be Numeric');

        IF NOT (FORMAT(p_gTextG5) IN ['0' .. '9']) THEN
            ERROR('Eight charecter need to be Numeric');

        IF NOT (FORMAT(p_gTextG6) IN ['0' .. '9']) THEN
            ERROR('Ninth charecter need to be Numeric');

        IF NOT (p_gText2 IN ['0' .. '9']) THEN
            ERROR('last charecter need to be Numeric');
        //
    end;


}