package net.nyx.printerclient;

public class Result {
    public static String msg(int code) {
        String s;
        switch (code) {
            case SdkResult.SDK_SENT_ERR:
                s = "Error de envío";
                break;
            case SdkResult.SDK_RECV_ERR:
                s = "Error del receptor";
                break;
            case SdkResult.SDK_TIMEOUT:
                s = "Tiempo de espera de comunicación";
                break;
            case SdkResult.SDK_PARAM_ERR:
                s = "Error de parámetros";
                break;
            case SdkResult.SDK_UNKNOWN_ERR:
                s = "Error desconocido";
                break;
            case SdkResult.SDK_FEATURE_NOT_SUPPORT:
                s = "Característica no compatible";
                break;
            case SdkResult.DEVICE_NOT_CONNECT:
                s = "Dispositivo no conectado";
                break;
            case SdkResult.DEVICE_DISCONNECT:
                s = "Dispositivo desconectado";
                break;
            case SdkResult.DEVICE_CONN_ERR:
                s = "Error de conexión del dispositivo";
                break;
            case SdkResult.DEVICE_CONNECTED:
                s = "Dispositivo conectado";
                break;
            case SdkResult.DEVICE_NOT_SUPPORT:
                s = "El dispositivo no es compatible";
                break;
            case SdkResult.DEVICE_NOT_FOUND:
                s = "Dispositivo no encontrado";
                break;
            case SdkResult.DEVICE_OPEN_ERR:
                s = "Error de apertura del dispositivo";
                break;
            case SdkResult.DEVICE_NO_PERMISSION:
                s = "Dispositivo sin permiso";
                break;
            case SdkResult.BT_NOT_OPEN:
                s = "Bluetooth no abierto";
                break;
            case SdkResult.BT_NO_LOCATION:
                s = "Ubicación no abierta";
                break;
            case SdkResult.BT_NO_BONDED_DEVICE:
                s = "Sin dispositivo adherido";
                break;
            case SdkResult.BT_SCAN_TIMEOUT:
                s = "Tiempo de espera de escaneo de Bluetooth";
                break;
            case SdkResult.BT_SCAN_ERR:
                s = "Error de escaneo de Bluetooth";
                break;
            case SdkResult.BT_SCAN_STOP:
                s = "Detinido por Bluetooth";
                break;
            case SdkResult.PRN_COVER_OPEN:
                s = "Tapa de la impresora abierta";
                break;
            case SdkResult.PRN_PARAM_ERR:
                s = "Error de parámetros de impresora";
                break;
            case SdkResult.PRN_NO_PAPER:
                s = "Impresora sin papel";
                break;
            case SdkResult.PRN_OVERHEAT:
                s = "Sobrecalentamiento de la impresora";
                break;
            case SdkResult.PRN_UNKNOWN_ERR:
                s = "Error de impresora desconocida";
                break;
            case SdkResult.PRN_PRINTING:
                s = "La impresora está imprimiendo";
                break;
            case SdkResult.PRN_NO_NFC:
                s = "Impresora sin NFC";
                break;
            case SdkResult.PRN_NFC_NO_PAPER:
                s = "Impresora NFC sin papel";
                break;
            case SdkResult.PRN_LOW_BATTERY:
                s = "Impresora con batería baja";
                break;
            case SdkResult.PRN_LBL_LOCATE_ERR:
                s = "Error de localización de la impresora";
                break;
            case SdkResult.PRN_LBL_DETECT_ERR:
                s = "Error de detección de etiquetas de impresora";
                break;
            case SdkResult.PRN_LBL_NO_DETECT:
                s = "No se ha detectado la etiqueta de la impresora";
                break;
            case SdkResult.PRN_UNKNOWN_CMD:
                s = "Error desconocido";
                break;
            default:
                s = "" + code;
                break;
        }
        return s;
    }
}
