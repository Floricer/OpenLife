package openlife.server;

import openlife.settings.ServerSettings;
import sys.io.File;

class PlayerAccount
{
    public static var AllPlayerAccounts = new Map<String, PlayerAccount>();
    
    public var lastConnection:Connection;

    public var email:String;
    public var account_key_hash:String;
    public var name:String = 'SNOW';

    public var score:Float;
    public var femaleScore:Float; 
    public var maleScore:Float; 

    public var lastSeenInTicks:Float;

    private function new(){}

    public static function GetOrCreatePlayerAccount(email:String, account_key_hash:String) : PlayerAccount
    {
        var account = AllPlayerAccounts[email];
        if(account != null) return account;

        account = new PlayerAccount();
        account.email = email;
        account.account_key_hash = account_key_hash;

        AllPlayerAccounts[account.email] = account;

        //trace('New account: $email');

        return account;
    }

    public static function WritePlayerAccounts(path:String)
    {
        var accounts = AllPlayerAccounts;

        //trace('Wrtie to file: $path width: $width height: $height length: $length');

        var writer = File.write(path, true);
        var dataVersion = 1;
        var count = 0;

        for(ac in accounts) count++;

        writer.writeInt32(dataVersion);
        writer.writeInt32(count);

        for(ac in accounts)
        {
            writer.writeString('${ac.email}\n');
            writer.writeString('${ac.account_key_hash}\n');
            writer.writeString('${ac.name}\n');

            writer.writeFloat(ac.score);
            writer.writeFloat(ac.femaleScore);
            writer.writeFloat(ac.maleScore);

            writer.writeDouble(ac.lastSeenInTicks);
        }

        writer.close();
    }

    public static function ReadPlayerAccounts(path:String)
    {
        var reader = File.read(path, true);
        var dataVersion = reader.readInt32();
        var count = reader.readInt32();
        AllPlayerAccounts = new Map<String, PlayerAccount>();

        trace('Read from file: $path count: $count');
        
        for(i in 0...count)
        {
            var email = reader.readLine();
            var account_key_hash = reader.readLine();
            var account = GetOrCreatePlayerAccount(email, account_key_hash);
            account.name = reader.readLine();

            account.score = reader.readFloat();
            account.femaleScore = reader.readFloat();
            account.maleScore = reader.readFloat();

            account.lastSeenInTicks = reader.readDouble();
        }

        reader.close();

        //trace('PlayerAccounts: $AllPlayerAccounts');
    }

    public function totalScore() : Float
    {
        return (maleScore + femaleScore) / 2; 
    }

    public static function ChangeScore(player:GlobalPlayerInstance)
    {
        // TODO give score to AI
        var account = player.connection.playerAccount;

        if(account == null) return;

        var score = player.yum_multiplier;
        var factor = ServerSettings.ScoreFactor;

        account.score = account.score * (1 - factor) + score * factor;
        
        if(player.isFemal()) account.femaleScore = account.femaleScore * (1 - factor) + score * factor;
        else account.maleScore = account.maleScore * (1 - factor) + score * factor;

        account.score = Math.round(account.score * 100) / 100;
        account.femaleScore = Math.round(account.femaleScore * 100) / 100;
        account.maleScore = Math.round(account.maleScore * 100) / 100;

        trace('Score: ${account.score} This Life: $score femaleScore: ${account.femaleScore} maleScore: ${account.maleScore}');
    }
}