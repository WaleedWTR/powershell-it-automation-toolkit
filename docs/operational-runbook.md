# Operational Runbook

## Intended use

The toolkit is designed to collect endpoint information in a consistent object-based format that can feed:

- troubleshooting
- readiness exercises
- migration planning
- asset validation
- compliance reporting
- service-desk diagnostics

## Recommended enterprise pattern

1. Sign and version scripts.
2. Test against representative hardware.
3. Run with least privilege.
4. Capture structured output centrally.
5. Avoid collecting unnecessary personal information.
6. Apply retention rules to inventory output.
7. Integrate with approved endpoint-management tooling rather than ad-hoc execution.

## Failure handling

The module deliberately checks whether BitLocker, TPM and Secure Boot cmdlets are available. Enterprise versions should also add:

- central logging
- retry logic
- explicit exit codes
- telemetry correlation IDs
- device-management deployment wrappers
