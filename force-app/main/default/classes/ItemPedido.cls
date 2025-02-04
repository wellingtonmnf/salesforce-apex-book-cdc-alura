public with sharing class ItemPedido {

    private Integer quantidade;
    private Decimal preco;
    private Decimal precoLiquido; 
    private Decimal total; 
    private Decimal totalLiquido;

    public ItemPedido() {
        this.quantidade = 0;
        this.preco = 0;
        this.precoLiquido = 0;
        this.total = 0;
        this.totalLiquido = 0;
    }

    public Integer getQuantidade() {
        return this.quantidade;
    }

    public void setQuantidade(Integer quantidade) {
        this.quantidade = quantidade;
    }

    public Decimal getPreco() {
        return this.preco;
    }

    public void setPreco(Decimal preco) {
        this.preco = preco;
    }

    public Decimal getPrecoLiquido() {
        return this.precoLiquido;
    }

    public void setPrecoLiquido(Decimal precoLiquido) {
        this.precoLiquido = precoLiquido;
    }

    public Decimal getTotal() {
        return this.preco * this.quantidade;
    }

    public Decimal getTotalLiquido() {
        return this.precoLiquido * this.quantidade;
    }


}