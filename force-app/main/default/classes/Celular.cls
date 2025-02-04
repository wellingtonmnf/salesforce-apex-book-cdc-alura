public with sharing class Celular {

    public Integer numeroNucleosProcessador;
    public Decimal peso;
    public String numero;
    public String marca;
    public String modelo;
    public String fabricante;
    public Boolean ligado;

    public Celular(){
        this.ligado = false;
    }

    public void discar (String numeroDestino){
        System.debug('Ligando para ' + numeroDestino + '\n De: ' + numero + '\n Marca/Modelo: ' + marca + '/' + modelo);
    }

    public void enviarMensagem (String numero, String mensagem){
        System.debug('[ ' + numero + ' ]\n' + 'Mensagem: ' + mensagem);
    }

}