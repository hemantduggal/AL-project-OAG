report 50006 Aged_report
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'MonthWise Aged Payable report';
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\aged_report1.rdl';
    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            column(CompanyName; CompanyInfo.Name)
            {

            }
            column(dueDate; dueDate)
            {

            }
            column(Vendor_No_; "Vendor No.")
            {

            }
            column(Vendor_Name; vendName)// "Vendor Name")
            {

            }
            column(vendName; vendName)
            {

            }
            column(Currency_Code; "Currency Code")
            {

            }
            column(Remaining_Amount; "Remaining Amount")
            {

            }
            column(Amount; Amount)
            {

            }
            column(CurMonthDue; CurMonthDue)
            {

            }
            column(lastmonthdue1; lastmonthdue1)
            {

            }
            column(lastmonthdue2; lastmonthdue2)
            {

            }
            column(lastmonthdue3; lastmonthdue3)
            {

            }
            column(Overalldue; Overalldue)
            {

            }
            column(FirstDate1; FirstDate1)
            {

            }
            column(FirtDate2; FirtDate2)
            {

            }
            column(firstdate3; firstdate3)
            {

            }
            column(firstDate4; firstDate4)
            {

            }
            trigger OnPreDataItem()
            begin
                SetRange("Due Date", 0D, dueDate);
            end;

            trigger OnAfterGetRecord()
            var
                VLERec: Record "Vendor Ledger Entry";
            begin
                Recvendor.Reset();
                if Recvendor.Get("Vendor No.") then
                    VendName := Recvendor.Name;



                clear(Overalldue);
                Clear(CurMonthDue);
                Clear(FirstDate1);
                Clear(LastDate1);
                LastDate1 := CALCDATE('CM', dueDate);
                FirstDate1 := CALCDATE('-CM', dueDate);

                VLERec.Reset();
                VLERec.SetRange("Due Date", 0D, LastDate1);
                VLERec.SetRange("Entry No.", "Entry No.");
                if VLERec.FindSet() then
                    repeat
                        Overalldue += "Remaining Amount";
                    until VLERec.Next() = 0;

                VLERec.Reset();
                VLERec.SetRange("Due Date", FirstDate1, LastDate1);
                VLERec.SetRange("Entry No.", "Entry No.");
                if VLERec.FindSet() then
                    repeat
                        CurMonthDue += "Remaining Amount";
                    until VLERec.Next() = 0;

                Clear(FirtDate2);
                Clear(lastmonthdue1);
                FirtDate2 := CalcDate('<-1M>', FirstDate1);
                VLERec.Reset();
                VLERec.SetRange("Due Date", FirtDate2, FirstDate1);
                VLERec.SetRange("Entry No.", "Entry No.");
                if VLERec.FindSet() then
                    repeat
                        lastmonthdue1 += "Remaining Amount";
                    until VLERec.Next() = 0;

                Clear(firstdate3);
                Clear(lastmonthdue2);
                firstdate3 := CalcDate('<-1M>', FirtDate2);
                VLERec.Reset();
                VLERec.SetRange("Due Date", firstdate3, FirtDate2);
                VLERec.SetRange("Entry No.", "Entry No.");
                if VLERec.FindSet() then
                    repeat
                        lastmonthdue2 += "Remaining Amount";
                    until VLERec.Next() = 0;

                clear(firstDate4);
                Clear(lastmonthdue3);
                firstdate4 := CalcDate('<-1M>', FirstDate3);
                VLERec.Reset();
                VLERec.SetRange("Due Date", 0D, firstdate3);
                VLERec.SetRange("Entry No.", "Entry No.");
                if VLERec.FindSet() then
                    repeat
                        lastmonthdue3 += "Remaining Amount";
                    until VLERec.Next() = 0;

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(dueDate; dueDate)
                    {
                        ApplicationArea = all;
                    }
                    field(edms; edms)
                    {
                        Caption = 'Save Document';
                        Editable = false;
                        ApplicationArea = All;

                        trigger OnDrillDown()
                        var
                            FileName: Text[100];
                            EDMSLin1: DotNet EDMSL;
                            Resp: Text[2999];
                        begin
                            FileName := 'D:\Upload\' + 'Upload' + '.pdf';
                            REPORT.SaveAsPdf(REPORT::Aged_report, FileName, "Vendor Ledger Entry");
                            EDMSLin1 := EDMSLin1.EDMSUpload();
                            Resp := EDMSLin1.UploadFile('1040', '1050', FileName, 'BC200', 'Catering');
                            Message(Resp);
                        end;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {

            }
        }
    }
    trigger OnInitReport()
    begin
        dueDate := System.Today;
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
    end;

    var
        companyinfo: Record "Company Information";
        dueDate: Date;
        LastDate1: Date;
        FirstDate1: date;
        CurMonthDue: Decimal;
        FirtDate2: date;
        lastmonthdue1: Decimal;
        firstdate3: Date;
        lastmonthdue2: Decimal;
        lastmonthdue3: Decimal;
        Overalldue: Decimal;
        firstDate4: date;
        recvendor: record Vendor;
        vendName: text[100];
        edms: Label 'Click to Save';
}