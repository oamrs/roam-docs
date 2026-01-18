# Enterprise Identity & BYOI

Roam implements a **"Bring Your Own Identity" (BYOI)** philosophy. Rather than forcing enterprises to rebuild their permission structures within Roam, the system mirrors existing identity providers (IdPs) to map tenants, roles, and agent capabilities.

## Unified Sync Architecture

Roam uses a pluggable sync engine to import organizational structures into separate **Dolt Branches** before merging them into the main policy database. This ensures:
1.  **Isolation**: Sync operations happen on branches (e.g., `import/ldap/2026-01-18`), preventing corruption of the live policy.
2.  **Auditing**: Administrators can view a diff of permissions (`dolt diff`) before applying changes.
3.  **Safety**: Bad syncs can be discarded without impact.

### Supported Providers

#### 1. LDAP / Active Directory
*   **Purpose**: Strategic Hierarchy & Multi-Tenancy.
*   **Mapping**:
    *   `OrganizationalUnit` (OU) → **Roam Organization** (Tenant).
    *   `Group` (memberOf) → **Roam Role**.
    *   Hierarchy is preserved: `Grandparents` → `Parents` → `Children`.
*   **Use Case**: Defining who belongs to which department or cost center.

#### 2. GitHub Teams / GitLab Groups
*   **Purpose**: Operational Teams.
*   **Mapping**:
    *   Teams/Groups → **Roam Organizations**.
    *   Repo Permissions (Read/Write/Admin) → **Agent Capabilities**.
*   **Use Case**: A "Code Review Agent" is only active for users who have `Write` access to the target repository.

#### 3. SQL Database Roles
*   **Purpose**: Data Governance & Row-Level Security.
*   **Mapping**:
    *   DB Users/Roles → **Agent Data Scopes**.
*   **Use Case**: An "SQL Analyst Agent" inherits the exact database permissions of the user invoking it, physically preventing unauthorized access to sensitive tables.

## Data Flow

1.  **Trigger**: Scheduled cron or API call via `/sync/{provider}`.
2.  **Branch**: System creates `import/{provider}/{timestamp}`.
3.  **Fetch**: Connects to IdP (LDAP/API) and traverses the tree.
4.  **Transform**: Maps external entities to the `organizations`, `users`, and `user_organizations` tables.
5.  **Commit**: Saves changes to the Dolt branch.
6.  **Verify**: Runs integrity checks (optional).
7.  **Merge**: Pull Request or fast-forward merge to `main`.
