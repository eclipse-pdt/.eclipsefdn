local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-pdt') {
  settings+: {
    dependabot_security_updates_enabled_for_new_repositories: false,
    description: "",
    name: "Eclipse PDT",
    readers_can_create_discussions: true,
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  _repositories+:: [
    orgs.newRepo('.github') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      workflows+: {
        actions_can_approve_pull_request_reviews: false,
      },
    },
    orgs.newRepo('pdt') {
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "PHP Development Tools project (PDT)",
      homepage: "https://eclipse.org/pdt",
      topics+: [
        "composer",
        "debugging",
        "eclipse",
        "java",
        "pdt",
        "php",
        "php-development",
        "phpunit",
        "profiling",
        "webdevelopment",
        "xdebug"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        actions_can_approve_pull_request_reviews: false,
      },
      webhooks: [
        orgs.newRepoWebhook('https://ci.eclipse.org/pdt/github-webhook/') {
          events+: [
            "push"
          ],
        },
        orgs.newRepoWebhook('https://ci.eclipse.org/pdt/ghprbhook/') {
          events+: [
            "issue_comment",
            "pull_request",
            "push"
          ],
        },
      ],
      secrets: [
        orgs.newRepoSecret('SONAR_TOKEN') {
          value: "********",
        },
      ],
      branch_protection_rules: [
        orgs.newBranchProtectionRule('master') {
          required_approving_review_count: null,
          requires_linear_history: true,
          requires_pull_request: false,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
        orgs.newBranchProtectionRule('stable-*') {
          required_approving_review_count: null,
          requires_linear_history: true,
          requires_pull_request: false,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
    },
    orgs.newRepo('pdt-website') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
    },
  ],
}
