xmlport 50000 "Import Budget Entries"
{
    Format = VariableText;
    Direction = Import;
    TextEncoding = WINDOWS;
    schema
    {
        textelement(Root)
        {
            tableelement("G/L Budget Entry"; "G/L Budget Entry")
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'Integer';
                SourceTableView = sorting("Entry No.");
                textattribute(GLAccNo)
                {
                }
                textattribute(budgetname)
                {

                }
                textattribute(Desc)
                {
                }
                textattribute(Pdate)
                {

                }
                textattribute(programCode)
                {
                }
                textattribute(Directorate)
                {
                }
                textattribute(FundingSrcCode)
                {

                }
                textattribute(ProjectCode)
                {
                }
                textattribute(BudgetOutput)
                {
                }

                textattribute(AuditEntities)
                {

                }

                textattribute(Amount)
                { }
                textattribute(BudgetType)
                { }
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
                    glbudget: Record "G/L Budget Entry";
                    glbudgetenrty: Record "G/L Budget Entry";
                    amt: Decimal;
                    gl: Record "G/L Account";
                begin
                    IF (SkipFirstLine = FALSE) THEN BEGIN
                        SkipFirstLine := TRUE;
                        currXMLport.SKIP;
                    END;
                    Clear(NextLineNo);
                    glbudget.Reset();
                    if glbudget.FindLast() then
                        NextLineNo := glbudget."Entry No." + 1
                    else
                        NextLineNo := 1;
                    glbudgetenrty.Init();
                    glbudgetenrty."Entry No." := NextLineNo;
                    glbudgetenrty.Description := Desc;
                    glbudgetenrty."Budget Name" := budgetname;
                    Evaluate(glbudgetenrty.Date, Pdate);
                    if gl.get(GLAccNo) then
                        glbudgetenrty."G/L Account No." := GLAccNo
                    else
                        Error('Gl account no. does not exists');
                    Evaluate(amt, Amount);
                    if amt > 0 then
                        glbudgetenrty.Amount := amt
                    else
                        Error('Amount must be greater than 0');
                    glbudgetenrty."Budget Type" := glbudgetenrty."Budget Type"::"Annual Budged";
                    glbudgetenrty."Global Dimension 1 Code" := programCode;
                    glbudgetenrty."Global Dimension 2 Code" := Directorate;
                    glbudgetenrty."Budget Dimension 2 Code" := BudgetOutput;
                    glbudgetenrty."Budget Dimension 3 Code" := AuditEntities;
                    glbudgetenrty.Insert();
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


