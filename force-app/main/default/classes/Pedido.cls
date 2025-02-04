public with sharing class Pedido {
    
    private Decimal total;
    private Decimal totalLiquido;
    private List<ItemPedido> itens;

    public Pedido() {
        this.total = 0;
        this.totalLiquido = 0;
        this.itens = new List<ItemPedido>();
    }

    public void adicionarItem(ItemPedido item) {
        this.itens.add(item);
        this.total += item.getTotal();
        this.totalLiquido += item.getTotalLiquido();
    }

    public Decimal getTotal() {
        return this.total;
    }

    public Decimal getTotalLiquido() {
        return this.totalLiquido;
    }
}