import javax.swing.JOptionPane;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ChurrascoApp {

    /**
     * Método para validar se a data é válida e está no ano de 2025.
     * Aceita formato "dd/MM/yyyy".
     */
    private static boolean dataValida2025(String dataStr) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        sdf.setLenient(false);
        try {
            Date data = sdf.parse(dataStr);
            // Checar se o ano é 2025
            String ano = new SimpleDateFormat("yyyy").format(data);
            return ano.equals("2025");
        } catch (ParseException e) {
            return false;
        }
    }

    public static void main(String[] args) {
        Churrasco churrasco = new Churrasco();

        // Ler nome do evento
        String nomeEvento = JOptionPane.showInputDialog(null, "Digite o nome do evento:");
        churrasco.setNomeEvento(nomeEvento);

        // Ler data do evento, validando para o ano 2025
        String dataEvento;
        do {
            dataEvento = JOptionPane.showInputDialog(null, "Digite a data do evento (dd/MM/yyyy) - só 2025:");
            if (!dataValida2025(dataEvento)) {
                JOptionPane.showMessageDialog(null, "Data inválida ou não está no ano de 2025. Por favor, digite novamente.");
            }
        } while (!dataValida2025(dataEvento));
        churrasco.setDataEvento(dataEvento);

        // Ler número de participantes (validação simples para positivo)
        int participantes = 0;
        do {
            String input = JOptionPane.showInputDialog(null, "Digite o número de participantes:");
            try {
                participantes = Integer.parseInt(input);
                if (participantes <= 0) {
                    JOptionPane.showMessageDialog(null, "Número de participantes deve ser maior que zero.");
                }
            } catch (NumberFormatException e) {
                JOptionPane.showMessageDialog(null, "Valor inválido. Digite um número inteiro.");
            }
        } while (participantes <= 0);
        churrasco.setNumeroParticipantes(participantes);

        // Função para ler preços double com validação
        double precoCarne = lerPreco("Digite o preço do quilo da carne bovina:");
        churrasco.setPrecoQuiloCarne(precoCarne);

        double precoLinguiça = lerPreco("Digite o preço do quilo da linguiça:");
        churrasco.setPrecoQuiloLinguiça(precoLinguiça);

        double precoRefrigerante = lerPreco("Digite o preço do litro do refrigerante:");
        churrasco.setPrecoLitroRefrigerante(precoRefrigerante);

        double precoLimpeza = lerPreco("Digite o preço da limpeza após o evento:");
        churrasco.setPrecoLimpeza(precoLimpeza);

        // Montar a mensagem de saída
        StringBuilder mensagem = new StringBuilder();
        mensagem.append("Custo total do churrasco: R$ ").append(String.format("%.2f", churrasco.getCustoTotal())).append("\n");
        mensagem.append("Lista de Compras:\n");
        for (String item : churrasco.getListaCompras()) {
            mensagem.append("- ").append(item).append("\n");
        }
        mensagem.append("Preço por participante: R$ ").append(String.format("%.2f", churrasco.getCustoPorParticipante()));

        // Mostrar a mensagem na janela de diálogo
        JOptionPane.showMessageDialog(null, mensagem.toString(), "Resumo do Churrasco", JOptionPane.INFORMATION_MESSAGE);
    }

    /**
     * Método auxiliar para ler preço com validação.
     */
    private static double lerPreco(String mensagem) {
        double preco = -1;
        do {
            String input = JOptionPane.showInputDialog(null, mensagem);
            try {
                preco = Double.parseDouble(input.replace(",", "."));
                if (preco < 0) {
                    JOptionPane.showMessageDialog(null, "Preço deve ser maior ou igual a zero.");
                }
            } catch (NumberFormatException e) {
                JOptionPane.showMessageDialog(null, "Valor inválido. Digite um número válido.");
            }
        } while (preco < 0);
        return preco;
    }
}
