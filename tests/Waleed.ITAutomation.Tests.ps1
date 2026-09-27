BeforeAll {
    Import-Module "$PSScriptRoot/../src/Waleed.ITAutomation.psm1" -Force
}

Describe 'ConvertTo-HealthStatus' {
    It 'returns Healthy when value meets threshold' {
        ConvertTo-HealthStatus -Value 25 -WarningThreshold 20 | Should -Be 'Healthy'
    }

    It 'returns Attention when value is below threshold' {
        ConvertTo-HealthStatus -Value 10 -WarningThreshold 20 | Should -Be 'Attention'
    }

    It 'treats threshold equality as healthy' {
        ConvertTo-HealthStatus -Value 20 -WarningThreshold 20 | Should -Be 'Healthy'
    }
}
