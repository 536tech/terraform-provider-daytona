// Copyright (c) Jonathan Moss.
// SPDX-License-Identifier: MPL-2.0

package provider

import (
	"testing"

	"github.com/hashicorp/terraform-plugin-testing/helper/resource"
)

func TestAccLookupDataSources_basic(t *testing.T) {
	testAccPreCheck(t)

	resource.Test(t, resource.TestCase{
		ProtoV6ProviderFactories: testAccProtoV6ProviderFactories,
		Steps: []resource.TestStep{
			{
				Config: `
provider "daytona" {}

data "daytona_current_api_key" "current" {}
data "daytona_api_key" "current" {
  name = data.daytona_current_api_key.current.name
}

data "daytona_organizations" "available" {}
data "daytona_organization" "selected" {
  id = data.daytona_organizations.available.items[0].id
}

data "daytona_organization_roles" "available" {
  organization_id = data.daytona_organization.selected.id
}
data "daytona_organization_role" "selected" {
  organization_id = data.daytona_organization.selected.id
  id              = data.daytona_organization_roles.available.items[0].id
}

data "daytona_organization_members" "available" {
  organization_id = data.daytona_organization.selected.id
}
data "daytona_organization_member" "selected" {
  organization_id = data.daytona_organization.selected.id
  user_id         = data.daytona_organization_members.available.items[0].user_id
}
`,
				Check: resource.ComposeAggregateTestCheckFunc(
					resource.TestCheckResourceAttrPair("data.daytona_api_key.current", "name", "data.daytona_current_api_key.current", "name"),
					resource.TestCheckResourceAttrSet("data.daytona_organization.selected", "name"),
					resource.TestCheckResourceAttrSet("data.daytona_organization_role.selected", "name"),
					resource.TestCheckResourceAttrSet("data.daytona_organization_member.selected", "email"),
				),
			},
		},
	})
}
