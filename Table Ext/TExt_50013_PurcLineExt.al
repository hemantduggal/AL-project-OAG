tableextension 50013 PurcLineExt extends "Purchase Line"
{
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                fa: Record "Fixed Asset";
            begin
                // if rec.Type = rec.Type::"Fixed Asset" then
                if fa.Get(Rec."No.") then begin
                    fa.CalcFields(Acquired);
                    if fa.Acquired = true then
                        Error('This Asset Is Already Acquired');
                end;
            end;
        }
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            begin
                // if type <> type::"Fixed Asset" then
                //     checkbudget();
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                // if type <> type::"Fixed Asset" then
                //     checkbudget();
            end;
        }
        modify("Line Amount")
        {
            trigger OnAfterValidate()
            begin
                // if type <> type::"Fixed Asset" then
                //     checkbudget();
            end;
        }
        modify("Quantity Received")
        {
            trigger OnAfterValidate()
            var
                smtp: Codeunit smtpmail;
                user: Record "User Setup";
            begin
                if user.get(UserId) then
                    smtp.sendmail('Approved : ', rec."No.", UserId, '', '', user."E-Mail", 'purchase recieved :' + Rec."No.");
            end;
        }
        field(50000; "Amount Inc VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';

        }
        field(50012; "WHT Business Posting Group"; Code[20])
        {
            Caption = 'WHT Business Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Business Posting Group";
        }
        field(50013; "WHT Product Posting Group"; Code[20])
        {
            Caption = 'WHT Product Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Product Posting Group";
        }
        field(50014; "WHT Absorb Base"; Decimal)
        {
            Caption = 'WHT Absorb Base';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
    }
    procedure checkbudget()
    var
        invpos: Record "Inventory Posting Setup";
        budg: Record BudgetQuater;
        item: Record item;
        amt: Decimal;
        Quar: option;
        postingdate: Date;
        year: code[20];
        header: Record "Purchase Header";
        accperiod: Record "Accounting Period";
        budhead: Record "OAG Budget Header";
        budgname: code[30];
    begin
        if rec."Document Type" <> rec."Document Type"::"Blanket Order" then begin
            clear(accperiod);
            clear(year);
            clear(budgname);
            clear(Quar);
            //TestField(Rec."Location Code");
            header.get(rec."Document Type", rec."Document No.");
            // Year := DATE2DMY(header."Posting Date", 3);
            postingdate := CALCDATE('-CM', header."Posting Date");
            if accperiod.Get(postingdate) then;
            year := accperiod."Code Type";
            Quar := accperiod.Quarter;

            budhead.SetRange(FinancialYear, year);
            if budhead.FindFirst() then
                budgname := budhead."Budget Name";

            Clear(amt);
            invpos.Reset();
            if rec.Type = rec.Type::Item then
                if item.Get(Rec."No.") then begin
                    invpos.get(Rec."Location Code", item."Inventory Posting Group");
                    budg.Reset();
                    budg.SetRange(BudgetName, budgname);
                    budg.SetRange(glacc, invpos."Inventory Account");
                    if Rec."Shortcut Dimension 1 Code" <> '' then
                        budg.SetRange(programcode, rec."Shortcut Dimension 1 Code");
                    if Rec."Shortcut Dimension 2 Code" <> '' then
                        budg.SetRange(directorate, rec."Shortcut Dimension 2 Code");
                    if budg.FindSet() then
                        repeat
                            if budg.Quater = budg.Quater::Q1 then
                                amt += budg.amount;
                            if budg.Quater = budg.Quater::Q2 then
                                amt += budg.amount;
                            if budg.Quater = budg.Quater::Q3 then
                                amt += budg.amount;
                            if budg.Quater = budg.Quater::Q4 then
                                amt += budg.amount;
                        until budg.Next() = 0;
                end;
            if rec.Type = rec.Type::"G/L Account" then begin
                budg.Reset();
                budg.SetRange(budgetname, budgname);
                budg.SetRange(glacc, rec."No.");
                if Rec."Shortcut Dimension 1 Code" <> '' then
                    budg.SetRange(programcode, rec."Shortcut Dimension 1 Code");
                if Rec."Shortcut Dimension 2 Code" <> '' then
                    budg.SetRange(directorate, rec."Shortcut Dimension 2 Code");
                if budg.FindSet() then
                    repeat
                        if budg.Quater = budg.Quater::Q1 then
                            amt += budg.amount;
                        if budg.Quater = budg.Quater::Q2 then
                            amt += budg.amount;
                        if budg.Quater = budg.Quater::Q3 then
                            amt += budg.amount;
                        if budg.Quater = budg.Quater::Q4 then
                            amt += budg.amount;
                    until budg.Next() = 0;
            end;


            if Rec.Quantity * rec."Direct Unit Cost" > amt then
                Error('Should not be greater than budget amount : %1', amt);
        end;
    end;

    var
        myInt: Integer;
}