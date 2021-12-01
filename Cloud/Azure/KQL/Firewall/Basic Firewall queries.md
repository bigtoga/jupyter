Easiest thing to do is:
1. Azure Portal
2. Azure Monitor
3. Logs
4. Click on "Queries" tab
5. Search for `Firewall`
6. Use one of the pre-built as a starter

```kusto
let web2 = "172.x.x.x";
let pip_appgw = "22.x.x.x";

AzureDiagnostics
| where Category == "AzureFirewallNetworkRule"
| where OperationName == "AzureFirewallNatRuleLog" or OperationName == "AzureFirewallNetworkRuleLog"
//case 1: for records that look like this:
//PROTO request from IP:PORT to IP:PORT.
| parse msg_s with Protocol " request from " SourceIP ":" SourcePortInt:int " to " TargetIP ":" TargetPortInt:int *
//case 1a: for regular network rules
| parse kind=regex flags=U msg_s with * ". Action\\: " Action1a "\\."
//case 1b: for NAT rules
//TCP request from IP:PORT to IP:PORT was DNAT'ed to IP:PORT
| parse msg_s with * " was " Action1b:string " to " TranslatedDestination:string ":" TranslatedPort:int *
//Parse rule data if present
| parse msg_s with * ". Policy: " Policy ". Rule Collection Group: " RuleCollectionGroup "." *
| parse msg_s with * " Rule Collection: "  RuleCollection ". Rule: " Rule 
//case 2: for ICMP records
//ICMP request from 10.0.2.4 to 10.0.3.4. Action: Allow
| parse msg_s with Protocol2 " request from " SourceIP2 " to " TargetIP2 ". Action: " Action2
| extend
SourcePort = tostring(SourcePortInt),
TargetPort = tostring(TargetPortInt)
| extend 
    Action = case(Action1a == "", case(Action1b == "",Action2,Action1b), split(Action1a,".")[0]),
    Protocol = case(Protocol == "", Protocol2, Protocol),
    SourceIP = case(SourceIP == "", SourceIP2, SourceIP),
    TargetIP = case(TargetIP == "", TargetIP2, TargetIP),
    //ICMP records don't have port information
    SourcePort = case(SourcePort == "", "N/A", SourcePort),
    TargetPort = case(TargetPort == "", "N/A", TargetPort),
    //Regular network rules don't have a DNAT destination
    TranslatedDestination = case(TranslatedDestination == "", "N/A", TranslatedDestination), 
    TranslatedPort = case(isnull(TranslatedPort), "N/A", tostring(TranslatedPort)),
    //Rule information
    Policy = case(Policy == "", "N/A", Policy),
    RuleCollectionGroup = case(RuleCollectionGroup == "", "N/A", RuleCollectionGroup ),
    RuleCollection = case(RuleCollection == "", "N/A", RuleCollection ),
    Rule = case(Rule == "", "N/A", Rule)
| where SourceIP == "172.x.x.x"
| where TargetIP == "22.x.x.x"
| where TargetPort == 443
| project TimeGenerated, msg_s, Protocol, SourceIP,SourcePort,TargetIP,TargetPort,Action, TranslatedDestination, TranslatedPort, Policy, RuleCollectionGroup, RuleCollection, Rule
```