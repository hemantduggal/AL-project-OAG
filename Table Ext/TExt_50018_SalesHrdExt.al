tableextension 50018 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(50009; "WHT Business Posting Group"; Code[20])
        {
            Caption = 'WHT Business Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Business Posting Group";

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
                //>>PRU_RPG  WHT Need to be Open later
                //IF xRec."WHT Business Posting Group" <> "WHT Business Posting Group" THEN
                //RecreateSalesLines(FIELDCAPTION("WHT Business Posting Group"));
                //<<PRU_RPG
            end;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                recC: record Customer;
            begin
                if recc.get("Sell-to Customer No.") then begin
                    "WHT Business Posting Group" := recc."WHT Business Posting Group";//neha
                end;
            end;
        }
    }

    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Sales Credit Memo');
        END;
        //PRU_DD 1.10
        /*  IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
              UserSetup.RESET;
              UserSetup.SETRANGE("User ID", USERID);
              UserSetup.SETFILTER(UserSetup.BlanketPurchaseOrder, '%1', UserSetup.BlanketPurchaseOrder::View);
              IF UserSetup.FINDFIRST THEN
                  ERROR('You do not have Permission to create Purchase Credit Memo');
          END;*/

        IF "Document Type" = "Document Type"::Invoice THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Sales Invoice');
        END;
        //PRU_DD 1.10

        IF "Document Type" = "Document Type"::Order THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Sales Order');
        END;
        //PRU_DD 1.10

        /*   IF "Document Type" = "Document Type"::Quote THEN BEGIN
               UserSetup.RESET;
               UserSetup.SETRANGE("User ID", USERID);
               UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
               IF UserSetup.FINDFIRST THEN
                   ERROR('You do not have Permission to create Purchase Quote');
           END;*/
        //PRU_DD 1.10

        IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Sales Return Order');
        END;
        //PRU_DD 1.10
    end;


    var



}