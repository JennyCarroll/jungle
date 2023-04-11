// feature spec that will test that users can click the 'Add to Cart' button for a product on the home page and in doing so their cart increases by one

describe("jungle app", () => {
  beforeEach(() => {
    cy.visit("http://0.0.0.0:3000");
  });

  it("should increase cart count by one when user click 'Add to Cart' button", () => {
    cy.get(".btn")
      .contains("Add")
      .first()
      .scrollIntoView()
      .click({ force: true });

    cy.get(".nav-link").contains("1");
  });
});
