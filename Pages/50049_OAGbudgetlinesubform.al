page 50049 oagbudgetsubform
{
    PageType = ListPart;
    //UsageCategory = Administration;
    PopulateAllFields = true;
    //ApplicationArea = all;
    SourceTable = BudgetLines;
    Caption = 'Budget SubForm';
    AutoSplitKey = true;
    Editable = true;
    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(BudgetStatus; Rec.BudgetStatus)
                {
                    // ApplicationArea = all;
                    Editable = false;
                }
                field("Budget name"; Rec."Budget name")
                {
                    Editable = false;
                }
                field(code; Rec.code)
                {
                    Caption = 'G/L Code';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(annualbudget; Rec.annualbudget)
                {
                    Caption = 'Annual Budget';
                    ApplicationArea = all;
                    // trigger OnDrillDown()
                    // var
                    //     budgetentry: Record "G/L Budget Entry";
                    //     fromdate: date;
                    //     todate: date;
                    //     year: Integer;
                    // begin
                    //     clear(fromdate);
                    //     clear(todate);
                    //     // Evaluate(fromdate, '01/07/' + format(rec.year - 2001));
                    //     // evaluate(todate, '30/07/' + format(rec.year - 2000));
                    //     // fromdate := CalcDate('DD/MM/YYYY', fromdate);
                    //     // todate := calcdate('DD/MM/YYYY', todate);
                    //     budgetentry.Reset();
                    //     budgetentry.SetRange("Budget Name", Rec."Budget name");
                    //     budgetentry.SetRange("G/L Account No.", rec.code);
                    //     // if rec.year <> 0 then
                    //     //     budgetentry.SetRange(date, fromdate, todate);
                    //     page.Run(page::"G/L Budget Entries", budgetentry);
                    // end;
                }
                field(Q1; Rec.Q1)
                {
                    Caption = 'Q1 Warrants';
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        budgetentry: Record BudgetQuater;
                        fromdate: date;
                        todate: date;
                        year: Integer;
                        budghead: Record "OAG Budget Header";
                    begin
                        clear(fromdate);
                        clear(todate);
                        // Evaluate(fromdate, '01/07/' + format(rec.year - 2001));
                        // evaluate(todate, '30/07/' + format(rec.year - 2000));
                        // fromdate := CalcDate('DD/MM/YYYY', fromdate);
                        // todate := calcdate('DD/MM/YYYY', todate);
                        budgetentry.Reset();
                        budgetentry.SetRange(BudgetName, Rec."Budget name");
                        budgetentry.SetRange(Quater, budgetentry.Quater::Q1);
                        budgetentry.SetRange(glacc, rec.code);
                        if budghead.programcode <> '' then
                            budgetentry.SetRange(programcode, budghead.programcode);
                        if budghead.auditentities <> '' then
                            budgetentry.SetRange(auditentities, budghead.auditentities);
                        if budghead.directorate <> '' then
                            budgetentry.SetRange(directorate, budghead.directorate);
                        if budghead.funding <> '' then
                            budgetentry.SetRange(funding, budghead.funding);
                        if budghead.projectfilter <> '' then
                            budgetentry.SetRange(projectfilter, budghead.projectfilter);
                        if budghead.budget5 <> '' then
                            budgetentry.SetRange(budget5, budghead.projectfilter);
                        if budghead.budgetoutput <> '' then
                            budgetentry.SetRange(budgetoutput, budghead.budgetoutput);
                        // if rec.year <> 0 then
                        //     budgetentry.SetRange(date, fromdate, todate);
                        page.Run(page::"Budget Quater", budgetentry);
                    end;
                }
                field(Q1encum; Rec.Q1encum)
                {
                    Caption = 'Q1 Encumbrance';
                    // ApplicationArea = all;
                }
                field(Q1paym; Rec.Q1paym)
                {
                    Caption = 'Q1 Payments';
                    // ApplicationArea = all;
                }
                field(Q2; Rec.Q2)
                {
                    Caption = 'Q2 Warrants';
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        budgetentry: Record BudgetQuater;
                        fromdate: date;
                        todate: date;
                        year: Integer;
                        budghead: Record "OAG Budget Header";
                    begin
                        clear(fromdate);
                        clear(todate);
                        // Evaluate(fromdate, '01/07/' + format(rec.year - 2001));
                        // evaluate(todate, '30/07/' + format(rec.year - 2000));
                        // fromdate := CalcDate('DD/MM/YYYY', fromdate);
                        // todate := calcdate('DD/MM/YYYY', todate);
                        budgetentry.Reset();
                        budgetentry.SetRange(BudgetName, Rec."Budget name");
                        budgetentry.SetRange(Quater, budgetentry.Quater::Q2);
                        budgetentry.SetRange(glacc, rec.code);
                        if budghead.programcode <> '' then
                            budgetentry.SetRange(programcode, budghead.programcode);
                        if budghead.auditentities <> '' then
                            budgetentry.SetRange(auditentities, budghead.auditentities);
                        if budghead.directorate <> '' then
                            budgetentry.SetRange(directorate, budghead.directorate);
                        if budghead.funding <> '' then
                            budgetentry.SetRange(funding, budghead.funding);
                        if budghead.projectfilter <> '' then
                            budgetentry.SetRange(projectfilter, budghead.projectfilter);
                        if budghead.budget5 <> '' then
                            budgetentry.SetRange(budget5, budghead.projectfilter);
                        if budghead.budgetoutput <> '' then
                            budgetentry.SetRange(budgetoutput, budghead.budgetoutput);
                        // if rec.year <> 0 then
                        //     budgetentry.SetRange(date, fromdate, todate);
                        page.Run(page::"Budget Quater", budgetentry);
                    end;
                }
                field(Q2encum; Rec.Q2encum)
                {
                    Caption = 'Q2 Encumbrance';
                    // ApplicationArea = all;
                }
                field(Q2paym; Rec.Q2paym)
                {
                    Caption = 'Q2 Payments';
                    // ApplicationArea = all;
                }
                field(Q3; Rec.Q3)
                {
                    Caption = 'Q3 Warrants';
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        budgetentry: Record BudgetQuater;
                        fromdate: date;
                        todate: date;
                        year: Integer;
                        budghead: Record "OAG Budget Header";
                    begin
                        clear(fromdate);
                        clear(todate);
                        // Evaluate(fromdate, '01/07/' + format(rec.year - 2001));
                        // evaluate(todate, '30/07/' + format(rec.year - 2000));
                        // fromdate := CalcDate('DD/MM/YYYY', fromdate);
                        // todate := calcdate('DD/MM/YYYY', todate);
                        budgetentry.Reset();
                        budgetentry.SetRange(BudgetName, Rec."Budget name");
                        budgetentry.SetRange(Quater, budgetentry.Quater::Q3);
                        budgetentry.SetRange(glacc, rec.code);
                        if budghead.programcode <> '' then
                            budgetentry.SetRange(programcode, budghead.programcode);
                        if budghead.auditentities <> '' then
                            budgetentry.SetRange(auditentities, budghead.auditentities);
                        if budghead.directorate <> '' then
                            budgetentry.SetRange(directorate, budghead.directorate);
                        if budghead.funding <> '' then
                            budgetentry.SetRange(funding, budghead.funding);
                        if budghead.projectfilter <> '' then
                            budgetentry.SetRange(projectfilter, budghead.projectfilter);
                        if budghead.budget5 <> '' then
                            budgetentry.SetRange(budget5, budghead.projectfilter);
                        if budghead.budgetoutput <> '' then
                            budgetentry.SetRange(budgetoutput, budghead.budgetoutput);
                        // if rec.year <> 0 then
                        //     budgetentry.SetRange(date, fromdate, todate);
                        page.Run(page::"Budget Quater", budgetentry);
                    end;
                }
                field(Q3encum; Rec.Q3encum)
                {
                    Caption = 'Q3 Encumbrance';
                    // ApplicationArea = all;
                }
                field(Q3paym; Rec.Q3paym)
                {
                    Caption = 'Q3 Payments';
                    // ApplicationArea = all;
                }
                field(Q4; Rec.Q4)
                {
                    Caption = 'Q4 Warrants';
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        budgetentry: Record BudgetQuater;
                        fromdate: date;
                        todate: date;
                        year: Integer;
                        budghead: Record "OAG Budget Header";
                    begin
                        clear(fromdate);
                        clear(todate);
                        // Evaluate(fromdate, '01/07/' + format(rec.year - 2001));
                        // evaluate(todate, '30/07/' + format(rec.year - 2000));
                        // fromdate := CalcDate('DD/MM/YYYY', fromdate);
                        // todate := calcdate('DD/MM/YYYY', todate);
                        budgetentry.Reset();
                        budgetentry.SetRange(BudgetName, Rec."Budget name");
                        budgetentry.SetRange(Quater, budgetentry.Quater::Q4);
                        budgetentry.SetRange(glacc, rec.code);
                        if budghead.programcode <> '' then
                            budgetentry.SetRange(programcode, budghead.programcode);
                        if budghead.auditentities <> '' then
                            budgetentry.SetRange(auditentities, budghead.auditentities);
                        if budghead.directorate <> '' then
                            budgetentry.SetRange(directorate, budghead.directorate);
                        if budghead.funding <> '' then
                            budgetentry.SetRange(funding, budghead.funding);
                        if budghead.projectfilter <> '' then
                            budgetentry.SetRange(projectfilter, budghead.projectfilter);
                        if budghead.budget5 <> '' then
                            budgetentry.SetRange(budget5, budghead.projectfilter);
                        if budghead.budgetoutput <> '' then
                            budgetentry.SetRange(budgetoutput, budghead.budgetoutput);
                        // if rec.year <> 0 then
                        //     budgetentry.SetRange(date, fromdate, todate);
                        page.Run(page::"Budget Quater", budgetentry);
                    end;
                }
                field(Q4encum; Rec.Q4encum)
                {
                    Caption = 'Q4 Encumbrance';
                    // ApplicationArea = all;
                }
                field(Q4paym; Rec.Q4paym)
                {
                    Caption = 'Q4 Payments';
                    // ApplicationArea = all;
                }
                field(supplementry; Rec.supplementry)
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        budgetentry: Record BudgetQuater;
                        fromdate: date;
                        todate: date;
                        year: Integer;
                    begin
                        clear(fromdate);
                        clear(todate);
                        // Evaluate(fromdate, '01/07/' + format(rec.year - 2001));
                        // evaluate(todate, '30/07/' + format(rec.year - 2000));
                        // fromdate := CalcDate('DD/MM/YYYY', fromdate);
                        // todate := calcdate('DD/MM/YYYY', todate);
                        budgetentry.Reset();
                        budgetentry.SetRange(BudgetName, Rec."Budget name");
                        budgetentry.SetRange(Is_Supplementry, budgetentry.Is_Supplementry::Y);
                        budgetentry.SetRange(glacc, rec.code);
                        // if rec.year <> 0 then
                        //     budgetentry.SetRange(date, fromdate, todate);
                        page.Run(page::"Budget Quater", budgetentry);
                    end;
                }
                field(totalencum; Rec.totalencum)
                {
                    ApplicationArea = all;
                    Caption = 'Encumbrance';
                }
                field(totalpay; Rec.totalpay)
                {
                    ApplicationArea = all;
                    Caption = 'Payments';
                }
                field(Warrants; Rec.warrents)
                {
                    Caption = 'Funds Available';
                    ApplicationArea = all;
                }

            }
        }
    }
    procedure annualbud()
    var
        budgetentry: Record "G/L Budget Entry";
        genjnl: Record "Gen. Journal Line";
        purchead: Record "Purchase Header";
        Pline: Record "Purchase Line";
        itemrec: Record Item;
        invsetup: Record "Inventory Posting Setup";
        fromdate: date;
        todate: date;
    begin
        clear(fromdate);
        clear(todate);
        Evaluate(fromdate, format(rec.year - 1) + '-01-07');
        evaluate(todate, format(rec.year) + '-30-06');
        budgetentry.Reset();
        budgetentry.SetRange("Budget Name", Rec."Budget name");
        if rec.datefilter <> '' then
            budgetentry.SetFilter(date, '%1..%2', fromdate, todate);
        if budgetentry.FindSet() then
            repeat
                rec.annualbudget += budgetentry.Amount;
            until budgetentry.Next() = 0;
        clear(fromdate);
        clear(todate);
        purchead.Reset();
        Evaluate(fromdate, format(rec.year - 1) + '-07-01');
        evaluate(todate, format(rec.year - 1) + '-10-01');
        purchead.setrange("Posting Date", fromdate, todate);
        if purchead.FindSet() then
            repeat
                Pline.Reset();
                Pline.SetRange("Document No.", purchead."No.");
                if Pline.FindSet() then
                    repeat
                        if Pline.Type = pline.Type::"G/L Account" then
                            if Rec.code = Pline."No." then begin
                                rec.Q1encum += Pline.Amount;
                            end;
                        if Pline.Type = pline.type::Item then
                            if itemrec.get(pline."No.") then begin
                                invsetup.Reset();
                                invsetup.SetRange("Location Code", Pline."Location Code");
                                invsetup.SetRange("Invt. Posting Group Code", itemrec."Inventory Posting Group");
                                if invsetup.FindFirst() then begin
                                    if rec.code = invsetup."Inventory Account" then
                                        rec.Q1encum += pline.Amount;
                                end;
                            end;
                    until Pline.Next() = 0;
            until purchead.Next() = 0;
        rec.Modify();
    end;
}