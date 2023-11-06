report 50026 deleteFA
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata "G/L Entry" = rimd;
    dataset
    {
        dataitem(Employee; Employee)
        {
            trigger OnAfterGetRecord()
            var
                genled: Record "G/L Entry";
            begin
                Employee."Employee Posting Group" := 'STATUTORY SALARIES';
                Employee.Modify();
            end;
        }
    }
}