public with sharing class Celular {

    public Integer numeroNucleosProcessador;
    public String marca;
    public String fabricante;
    public String modelo;
    public Long numero;
    public Decimal peso;
    public Boolean ligado;

    public Celular(){
        this.ligado = false;
    }

    public Celular(Long numero){
        this.ligado = false;
        this.numero = numero;
    }

    public void discar (String numeroDestino){
        System.debug('Ligando para ' + numeroDestino 
                                     + '\n De: ' + numero 
                                     + '\n Marca/Modelo: ' 
                                     + marca + '/' + modelo);
    }

    public void enviarMensagem (String numero, String mensagem){
        System.debug('Enviando a mensagem para ' + numero 
                                                 + ' \n' + 'Mensagem: ' 
                                                 + mensagem);
    }

}