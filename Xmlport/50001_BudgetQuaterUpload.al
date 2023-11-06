xmlport 50001 "Import Quater Budget"
{
    Format = VariableText;
    Direction = Import;
    TextEncoding = WINDOWS;
    schema
    {
        textelement(Root)
        {
            tableelement(BudgetQuater; BudgetQuater)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'Integer';
                SourceTableView = sorting("Entry No.");
                textattribute(budgetname)
                {

                }
                textattribute(GLAccNo)
                {
                }
                textattribute(quater)
                {

                }
                textattribute(is_supplement)
                {

                }
                textattribute(Amount)
                { }
                textattribute(Programme)
                {
                }
                textattribute(directorate)
                { }
                textattribute(fundcode)
                { }
                textattribute(funding)
                { }
                textattribute(project)
                { }
                textattribute(budgetoutput)
                { }
                textattribute(auditentity)
                { }
                textattribute(auditsegment)
                {

                }
                textattribute(budgetcategry)
                {

                }
                trigger OnAfterInitRecord()
                begin
                    IF (SkipFirstLine = FALSE) THEN BEGIN
                        SkipFirstLine := TRUE;
                        currXMLport.SKIP;
                    END;
                end;

                trigger OnAfterInsertRecord()
                begin
                    IF (SkipFirstLine = FALSE) THEN
                        SkipFirstLine := TRUE;
                end;

                trigger OnBeforeInsertRecord()
                var
                    glbudget: Record BudgetQuater;
                    bud_header: Record "OAG Budget Header";
                    glbudgetenrty: Record "G/L Budget Entry";
                    amt: Decimal;
                    gl: Record "G/L Account";
                    budlines: Record BudgetLines;
                begin
                    IF (SkipFirstLine = FALSE) THEN BEGIN
                        SkipFirstLine := TRUE;
                        currXMLport.SKIP;
                    END;
                    budlines.SetRange("Budget name", budgetname);
                    budlines.SetRange(code, GLAccNo);
                    if budlines.FindFirst() then begin
                        Evaluate(amt, Amount);
                        if budlines.annualbudget < amt then
                            Error('Can not be greater than annual budget amount');
                    end;
                    glbudget.Reset();
                    glbudget.Validate(BudgetName, budgetname);
                    bud_header.Reset();
                    bud_header.SetRange("Budget Name", budgetname);
                    if bud_header.FindFirst() then
                        glbudget.BudgetStatus := bud_header.BudgetStatus;
                    glbudget.Validate(glacc, GLAccNo);
                    if gl.get(GLAccNo) then
                        glbudget.Description := gl.Name;
                    Evaluate(glbudget.Quater, quater);
                    Evaluate(glbudget.Is_Supplementry, is_supplement);
                    Evaluate(glbudget.amount, Amount);
                    glbudget.Validate(programcode, Programme);
                    glbudget.Validate(directorate, directorate);
                    glbudget.Validate(auditentities, auditentity);
                    glbudget.Validate(projectfilter, project);
                    glbudget.Validate(funding, funding);
                    glbudget.Validate(budget5, fundcode);
                    glbudget.Validate(budgetoutput, budgetoutput);
                    glbudget.Validate(auditsegment, auditsegment);
                    glbudget.Validate(budgetcategory, budgetcategry);
                    glbudget.isreallocated := false;
                    glbudget.Insert();
                end;
            }
        }
    }
    local procedure GetNextLineNo(): Integer;
    var
        NextWorkorderLine: Record "G/L Budget Entry";
    begin
        NextWorkorderLine.Reset();
        // NextWorkorderLine.SetRange("Document No.", DocumNo);
        if NextWorkorderLine.FindLast() then
            exit(NextWorkorderLine."Entry No." + 10000)
        else
            exit(1);
    end;

    procedure SetSalesHeader(DocNo: Code[20])
    begin
        //SalesHeader := SHeader;
        DocumNo := DocNo;
    end;

    var
        SHno: Code[20];
        DocumNo: Code[20];
        SalesHeader: Record "Sales Header";
        SalesLine: Record "G/L Budget Entry";
        NoOfLoops, NextLineNo : Integer;
        SkipFirstLine: Boolean;
}


