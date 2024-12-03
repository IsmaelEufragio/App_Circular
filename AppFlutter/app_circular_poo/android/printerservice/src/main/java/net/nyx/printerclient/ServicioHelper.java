package net.nyx.printerclient;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.graphics.Bitmap;
import android.nfc.Tag;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.RemoteException;
import android.util.Log;

import net.nyx.printerservice.print.IPrinterService;
import net.nyx.printerservice.print.PrintTextFormat;

import static net.nyx.printerclient.Result.msg;
public class ServicioHelper {
    private IPrinterService printerService;
    private boolean isBound = false;

    public interface RespuestaCallback<T> {
        void onSuccess(RespuestaServicio<T> respuesta);
        void onError(RespuestaServicio<T> error);
    }
    public void conectarServicio(Context context) {
        Intent intent = new Intent();
        intent.setPackage("net.nyx.printerservice");
        intent.setAction("net.nyx.printerservice.IPrinterService");
        boolean isBound = context.bindService(intent, serviceConnection, context.BIND_AUTO_CREATE);
    }

    public void desconectarServicio(Context context) {
        if (isBound) {
            context.unbindService(serviceConnection);
            isBound = false;
        }
    }

    private final ServiceConnection serviceConnection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            printerService = IPrinterService.Stub.asInterface(service);
            isBound = true;
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            printerService = null;
            isBound = false;
        }
    };

    /*
     *   Controle el estado de la pantalla LCD del cliente
     *   parametro 0--Iniciar, 1--Activar, LCD 2--Invernar, LCD 3--Limpiar, LCD 4--Reiniciar. LCD display
     * */
    public void configLcdAsync(int parametro, RespuestaCallback<String> callback) {
        // Ejecutar en un hilo de fondo
        new Thread(() -> {
            try {
                // Verificar si el servicio está conectado
                if (printerService == null) {
                    throw new IllegalStateException("El servicio no está conectado");
                }

                // Llamar al método remoto
                int resultado = printerService.configLcd(parametro);

                // Crear una respuesta basada en el resultado
                RespuestaServicio<String> respuesta;
                if (resultado == 0) {
                    respuesta = new RespuestaServicio<>(true, "Operación exitosa", "Todo Bien");
                } else {
                    respuesta = new RespuestaServicio<>(false, msg(resultado), null);
                }

                // Devolver la respuesta al hilo principal
                postToMainThread(() -> callback.onSuccess(respuesta));

            } catch (Exception e) {
                // Crear una respuesta de error
                RespuestaServicio<String> error = new RespuestaServicio<>(false, e.getMessage(), null);

                // Devolver el error al hilo principal
                postToMainThread(() -> callback.onError(error));
            }
        }).start();
    }

    //Version de la impresora.
    public void getPrinterVersionAsync(RespuestaCallback<String> callback){
        new Thread(()-> {
            try {
                if(printerService == null){
                    throw new IllegalStateException("El servicio No esta conectado.");
                }
                String[] version = new String[1];
                int rst = printerService.getPrinterVersion(version);
                RespuestaServicio<String> respuesta;
                if (rst == 0) {
                    respuesta = new RespuestaServicio<>(true, "Operación exitosa", version[0]);
                } else {
                    respuesta = new RespuestaServicio<>(false, msg(rst), null);
                }
                postToMainThread(() -> callback.onSuccess(respuesta));

            }catch (RemoteException e){

                RespuestaServicio<String> error = new RespuestaServicio<>(false, e.getMessage(), null);
                postToMainThread(() -> callback.onError(error));
            }
        }).start();
    }

    //px de salida de papel por cada imprecion.
    public void paperOutAsync(int px, RespuestaCallback<String> callback){
        new Thread(()-> {
            try{
                if(printerService == null){
                    throw new IllegalStateException("El servicio No esta conectado.");
                }
                int rst = printerService.paperOut(px);
                RespuestaServicio<String> respuesta;
                if (rst == 0) {
                    respuesta = new RespuestaServicio<>(true, "Operación exitosa", "Todo bien");
                } else {
                    respuesta = new RespuestaServicio<>(false, msg(rst), null);
                }
                postToMainThread(() -> callback.onSuccess(respuesta));
            }catch (RemoteException e){
                RespuestaServicio<String> error = new RespuestaServicio<>(false, e.getMessage(), null);
                postToMainThread(() -> callback.onError(error));
            }
        }).start();
    }

    //Imprime un texto con un estilo por defecto.
    public void printTextAsync(String text, RespuestaCallback<String> callback){
        new Thread(()->{
            try{
                if(printerService == null){
                    throw new IllegalStateException("El Servidor no esta conectado.");
                }
                PrintTextFormat textFormat = new PrintTextFormat();
                int rst = printerService.printText(text,textFormat);
                RespuestaServicio<String> respuesta;
                if (rst == 0) {
                    respuesta = new RespuestaServicio<>(true, "Operación exitosa", "Todo bien");
                } else {
                    respuesta = new RespuestaServicio<>(false, msg(rst), null);
                }
                postToMainThread(() -> callback.onSuccess(respuesta));
            }catch (RemoteException e){
                RespuestaServicio<String> error = new RespuestaServicio<>(false, e.getMessage(), null);
                postToMainThread(() -> callback.onError(error));
            }
        }).start();
    }


    /**
     * Imprime Un codigo de Barra
     *
     * @param content      Contenido Codigo Barra
     * @param width        Ancho Codigo Barra, px
     * @param height       Alto Codigo Barra, px
     * @param textPosition La Posicion del codigo de barra, Opcion por defecto 0.
     *                     0--No imprimas el contenido del código de barras.
     *                     1--Contenido sobre el código de barras
     *                     2--Contenido debajo del código de barras
     *                     3--Texto Imprime tanto la parte superior como la inferior del código de barras
     * @param align        Alinacion, Por defecto es 0.
     *                     0--Alinear a la izquierda,
     *                     1--Alinear al centro,
     *                     2--Alinear a la derecha.
     */
    public void printBarcodeAsync(String content,int width,int height,int textPosition,int align,RespuestaCallback<String> callback){
        new Thread(()->{
            try{
                if(printerService == null){
                    throw new IllegalStateException("El Servidor no esta conectado.");
                }
                PrintTextFormat textFormat = new PrintTextFormat();
                int rst = printerService.printBarcode(content,width,height,textPosition,align);
                RespuestaServicio<String> respuesta;
                if (rst == 0) {
                    respuesta = new RespuestaServicio<>(true, "Operación exitosa", "Todo bien");
                } else {
                    respuesta = new RespuestaServicio<>(false, msg(rst), null);
                }
                postToMainThread(() -> callback.onSuccess(respuesta));
            }catch (RemoteException e){
                RespuestaServicio<String> error = new RespuestaServicio<>(false, e.getMessage(), null);
                postToMainThread(() -> callback.onError(error));
            }
        }).start();
    }

    /**
     * Imprimir código QR
     *
     * @param content Contenido de CodigoQR
     * @param width   Ancho del CodigoQR, px
     * @param height  Lato del CodigoQR, px
     * @param align   Alinacion, La Sero por defecto 0.
     *                0--Alinear a la izquierda,
     *                1--Alinear al centro,
     *                2--Alinear a la derecha
     */
    public void printQrCodeAsync(String content,int width,int height,int align,RespuestaCallback<String> callback){
        new Thread(()->{
            try{
                if(printerService == null){
                    throw new IllegalStateException("El Servidor no esta conectado.");
                }
                PrintTextFormat textFormat = new PrintTextFormat();
                int rst = printerService.printQrCode(content,width,height,align);
                RespuestaServicio<String> respuesta;
                if (rst == 0) {
                    respuesta = new RespuestaServicio<>(true, "Operación exitosa", "Todo bien");
                } else {
                    respuesta = new RespuestaServicio<>(false, msg(rst), null);
                }
                postToMainThread(() -> callback.onSuccess(respuesta));
            }catch (RemoteException e){
                RespuestaServicio<String> error = new RespuestaServicio<>(false, e.getMessage(), null);
                postToMainThread(() -> callback.onError(error));
            }
        }).start();
    }

    /**
     * Imprimir mapa de bits
     *
     * @param contenido Objeto de mapa de bits de Android
     * @param tipo   tipo de renderizado de impresora, el valor predeterminado es 0.
     *               0--Mapa de bits en blanco y negro
     *               1--Mapa de bits en escala de grises, adecuado para imágenes de colores enriquecidos
     * @param alinacion  Alinacion, La Sero por defecto 0.
     *               0--Alinear a la izquierda,
     *               1--Alinear al centro,
     *               2--Alinear a la derecha
     */
    public void printBitmapAsync(Bitmap contenido, int tipo, int alinacion ,RespuestaCallback<String> callback){
        new Thread(()->{
            try{
                if(printerService == null){
                    throw new IllegalStateException("El Servidor no esta conectado.");
                }
                PrintTextFormat textFormat = new PrintTextFormat();
                int rst = printerService.printBitmap(contenido,tipo,alinacion);
                RespuestaServicio<String> respuesta;
                if (rst == 0) {
                    respuesta = new RespuestaServicio<>(true, "Operación exitosa", "Todo bien");
                } else {
                    respuesta = new RespuestaServicio<>(false, msg(rst), null);
                }
                postToMainThread(() -> callback.onSuccess(respuesta));
            }catch (RemoteException e){
                RespuestaServicio<String> error = new RespuestaServicio<>(false, e.getMessage(), null);
                postToMainThread(() -> callback.onError(error));
            }
        }).start();
    }
    /**
     *   Es para dar un espacio despues de imprimir.
     */
    public void printEndAutoOutAsync(RespuestaCallback<String> callback){
        new Thread(()->{
            try{
                if(printerService == null){
                    throw new IllegalStateException("El Servidor no esta conectado.");
                }
                PrintTextFormat textFormat = new PrintTextFormat();
                int rst = printerService.printEndAutoOut();
                RespuestaServicio<String> respuesta;
                if (rst == 0) {
                    respuesta = new RespuestaServicio<>(true, "Operación exitosa", "Todo bien");
                } else {
                    respuesta = new RespuestaServicio<>(false, msg(rst), null);
                }
                postToMainThread(() -> callback.onSuccess(respuesta));
            }catch (RemoteException e){
                RespuestaServicio<String> error = new RespuestaServicio<>(false, e.getMessage(), null);
                postToMainThread(() -> callback.onError(error));
            }
        }).start();
    }

    public void getPrinterModelAsync(RespuestaCallback<String> callback){
        new Thread(()-> {
            try {
                if(printerService == null){
                    throw new IllegalStateException("El servicio No esta conectado.");
                }
                String[] version = new String[1];
                int rst = printerService.getPrinterModel(version);
                RespuestaServicio<String> respuesta;
                if (rst == 0) {
                    respuesta = new RespuestaServicio<>(true, "Operación exitosa", version[0]);
                } else {
                    respuesta = new RespuestaServicio<>(false, msg(rst), null);
                }
                postToMainThread(() -> callback.onSuccess(respuesta));

            }catch (RemoteException e){

                RespuestaServicio<String> error = new RespuestaServicio<>(false, e.getMessage(), null);
                postToMainThread(() -> callback.onError(error));
            }
        }).start();
    }

    public void getPrinterStatusAsync(RespuestaCallback<String> callback){
        new Thread(()-> {
            try {
                if(printerService == null){
                    throw new IllegalStateException("El servicio No esta conectado.");
                }
                String[] version = new String[1];
                int rst = printerService.getPrinterStatus();
                RespuestaServicio<String> respuesta;
                respuesta = new RespuestaServicio<>(true, msg(rst), "Todo bien.");
                postToMainThread(() -> callback.onSuccess(respuesta));
            }catch (RemoteException e){

                RespuestaServicio<String> error = new RespuestaServicio<>(false, e.getMessage(), null);
                postToMainThread(() -> callback.onError(error));
            }
        }).start();
    }

    //px para contrar el retroceso.
    public void paperBackAsync(int px, RespuestaCallback<String> callback){
        new Thread(()-> {
            try{
                if(printerService == null){
                    throw new IllegalStateException("El servicio No esta conectado.");
                }
                int rst = printerService.paperBack(px);
                RespuestaServicio<String> respuesta;
                if (rst == 0) {
                    respuesta = new RespuestaServicio<>(true, "Operación exitosa", "Todo bien");
                } else {
                    respuesta = new RespuestaServicio<>(false, msg(rst), null);
                }
                postToMainThread(() -> callback.onSuccess(respuesta));
            }catch (RemoteException e){
                RespuestaServicio<String> error = new RespuestaServicio<>(false, e.getMessage(), null);
                postToMainThread(() -> callback.onError(error));
            }
        }).start();
    }

    // Método auxiliar para ejecutar tareas en el hilo principal
    private void postToMainThread(Runnable task) {
        new Handler(Looper.getMainLooper()).post(task);
    }
}
